-- Export different folders into seperate color channels

local sprite = app.sprite
if not sprite then return print('No active sprite') end

-- Helper to find a layer by name (case-insensitive)
local function findGroup(name)
  for _, layer in ipairs(sprite.layers) do
    if layer.isGroup and layer.name:lower() == name:lower() then
      return layer
    end
  end
  return nil
end

-- Helper to flatten a group to a single image for a given frame
local function flattenGroupImage(group, frameNumber)
  local img = Image(sprite.width, sprite.height, ColorMode.RGBA)
  for _, layer in ipairs(group.layers) do
    if layer.isImage and layer.isVisible then
      local cel = layer:cel(frameNumber)
      if cel then
        img:drawImage(cel.image, cel.position)
      end
    end
  end
  return img
end

-- Get the groups
local normalsGroup = findGroup("normal")
local roughnessGroup = findGroup("roughness")
local depthGroup = findGroup("depth")

if not (normalsGroup and roughnessGroup and depthGroup) then
  app.alert("Missing one or more required layers: 'normal', 'roughness', 'depth'")
  return
end

local width, height = sprite.width, sprite.height
local resultImage = Image(width, height, ColorMode.RGBA)

local frame = 1 -- Only using the first frame for now

-- Flatten each group
local normalsImage   = flattenGroupImage(normalsGroup, frame)
local roughnessImage = flattenGroupImage(roughnessGroup, frame)
local depthImage     = flattenGroupImage(depthGroup, frame)

-- Compose final packed image
for y = 0, height - 1 do
  for x = 0, width - 1 do
    local normals = normalsImage:getPixel(x, y)
    local roughness = roughnessImage:getPixel(x, y)
    local depth = depthImage:getPixel(x, y)

    local r = app.pixelColor.rgbaR(normals)
    local g = app.pixelColor.rgbaG(normals)
    local b = app.pixelColor.rgbaR(depth) -- depth = grayscale
    local a = app.pixelColor.rgbaR(roughness) -- roughness = grayscale

    local packed = app.pixelColor.rgba(r, g, b, a)
    resultImage:putPixel(x, y, packed)
  end
end

-- Save to file
local output = Sprite(width, height)
output.layers[1]:cel(1).image = resultImage

app.command.SaveFileAs{}

output:close()