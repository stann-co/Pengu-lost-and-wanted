import { Yy } from '@bscotch/yy';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

/**
 * Enum for common colors.
 * @readonly
 * @enum number
 */
const ElementType = Object.freeze({
  INSTANCE:   2,
  ASSET:  4,
	TILEMAP: 5,
});

// Base layer template with common properties
//#region Layer Templates
const BaseLayer = {
	"animationFPS":			15.0,
	"animationSpeedType":	0,
	"effectEnabled":		true,
	"effectType":			null,
	"gridX":				32,
	"gridY":				32,
	"hierarchyFrozen":		false,
	"inheritLayerDepth":	false,
	"inheritLayerSettings":	false,
	"inheritSubLayers":		true,
	"inheritVisibility":	true,
	"layers":				[],
	"properties":			[],
	"resourceVersion":		"2.0",
	"userdefinedDepth":		false,
	"visible":				true,
};

/* const EffectLayer =     {
	...BaseLayer,
	"$GMREffectLayer":		"",
	"%Name":				"Effect_1",
	"depth":				0,
	"name":					"Effect_1",
	"resourceType":			"GMREffectLayer",
}; */

const AssetLayer =      {
	...BaseLayer,
	"$GMRAssetLayer":		"",
	"%Name":				"Assets_1",
	"assets":				[],
	"depth":				100,
	"name":					"Assets_1",
	"resourceType":			"GMRAssetLayer",
};

/* const PathLayer =       {
	...BaseLayer,
	"$GMRPathLayer":		"",
	"%Name":				"Path_1",
	"colour":				4278190335,
	"depth":				200,
	"name":					"Path_1",
	"pathId":				null,
	"resourceType":			"GMRPathLayer",
}; */

const TileLayer =       {
	...BaseLayer,
	"$GMRTileLayer":		"",
	"%Name":				"Tiles_1",
	"depth":				300,
	"name":					"Tiles_1",
	"resourceType":			"GMRTileLayer",
	"tiles":				{"SerialiseHeight":0,"SerialiseWidth":0,"TileSerialiseData":[]},
	"tilesetId":			null,
	"x":					0,
	"y":					0,
};

/* const InstanceLayer =   {
	...BaseLayer,
	"$GMRInstanceLayer":	"",
	"%Name":				"Instances",
	"depth":				400,
	"instances":			[],
	"name":					"Instances",
	"resourceType":			"GMRInstanceLayer",
};

const BackgroundLayer = {
	...BaseLayer,
	"$GMRBackgroundLayer":	"",
	"%Name":				"Background",
	"colour":				4278190080,
	"depth":				500,
	"hspeed":				0.0,
	"htiled":				false,
	"name":					"Background",
	"resourceType":			"GMRBackgroundLayer",
	"spriteId":				null,
	"stretch":				false,
	"userdefinedAnimFPS":	false,
	"vspeed":				0.0,
	"vtiled":				false,
	"x":					0,
	"y":					0,
}; */
//#endregion

function Sprite(_sprite_name) {
  //'@ref sprite(spr_points)' -> spr_points
  const reg = /\w*(?=\))/;
  _sprite_name = reg.exec(_sprite_name)[0];

  this.name = _sprite_name;
  this.path = `sprites/${_sprite_name}/${_sprite_name}.yy`;
}

/**
 * Combines BGR color (24-bit) and alpha (0.0-1.0 float) into a 32-bit AABBGGRR value.
 * @param {number} bgr - 24-bit BGR color (0xBBGGRR)
 * @param {number} alpha - Alpha value as float (0.0-1.0)
 * @returns {number} 32-bit AABBGGRR color
 */
function colour(bgr, alpha) {
	const a = Math.round(alpha * 255) & 0xFF;
	const bgr24 = bgr & 0xFFFFFF;
	return ((a << 24) | bgr24) >>> 0;
}

const Asset = {
  "$GMRSpriteGraphic":"v1",
  "%Name":"graphic_000000",
  "animationSpeed":1.0,
  "colour":4294967295,
  "frozen":false,
  "headPosition":0.0,
  "ignore":false,
  "inheritedItemId":null,
  "inheritItemSettings":false,
  "name":"graphic_000000",
  "resourceType":"GMRSpriteGraphic",
  "resourceVersion":"2.0",
  "rotation":0.0,
  "scaleX":1.0,
  "scaleY":1.0,
  "spriteId":{
    "name":"spr_points",
    "path":"sprites/spr_points/spr_points.yy",
  },
  "x":0.0,
  "y":0.0,
}

const Tiles = {
  "SerialiseHeight":4,
  "SerialiseWidth":4,
  "TileCompressedData":[0],
  "TileDataFormat":1,
}

const roomName = process.argv[2];

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const roomdata_path = path.join(__dirname, "temp_room_data.json");

const roomDataObj = Yy.readSync(roomdata_path);

let roomFileObj = Yy.readSync(path.join(__dirname, `../../rooms/${roomName}/${roomName}.yy`));

roomFileObj.roomSettings.Width = roomDataObj.width;
roomFileObj.roomSettings.Height = roomDataObj.height;

//only updates asset and tile layers
for (let i = 0; i < roomFileObj.layers.length; i++) {
  let layer = roomFileObj.layers[i];
  let dataLayer = roomDataObj.layers[i];
  console.log(`Processing layer: ${layer["%Name"]}`);

  //updates asset layer
  if ('$GMRAssetLayer' in layer) {
    console.log(`Updating asset layer: ${layer["%Name"]}`);

    //clear assets
    layer.assets = [];

    //add new assets
    for (let j = 0; j < dataLayer.elements.length; j++) {
      const assetData = dataLayer.elements[j];
      console.log(assetData);

      let asset = Asset;
      asset.name = assetData.name;
      asset['%Name'] = asset.name;
      asset.animationSpeed = assetData.image_speed;
      asset.colour = colour(assetData.image_blend, assetData.image_alpha);
      console.log(`Colour set to: ${asset.colour}`);
      asset.headPosition = assetData.image_index;
      asset.rotation = assetData.image_angle;
      asset.scaleX = assetData.image_xscale;
      asset.scaleY = assetData.image_yscale;
      asset.spriteId = new Sprite(assetData.sprite_index);
      asset.x = assetData.x;
      asset.y = assetData.y;

      layer.assets.push(asset);
      console.log(`Added asset: ${asset.name}`);
    }
  }
  
  //updates tile layer
  else if ('$GMRTileLayer' in layer) {
    //update tileset id
/*     layer.tilesetId = {
      "name": roomDataObj.tilesetName,
      "path": `tilesets/${roomDataObj.tilesetName}/${roomDataObj.tilesetName}.yy`,
    };
    //update tile data
    layer.tiles = JSON.parse(JSON.stringify(Tiles)); */
  }

}

console.log(roomName);
Yy.writeSync(path.join(__dirname, `../../rooms/${roomName}/${roomName}.yy`), roomFileObj);

//const outputPath = path.join(__dirname, 'test.txt');
//fs.writeFileSync(outputPath, "is this working?");