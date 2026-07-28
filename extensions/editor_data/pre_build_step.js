import { Yy } from '@bscotch/yy';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Decode TileCompressedData (GameMaker RLE):
// Positive N -> next N literal tile values
// Negative -N -> next value is repeated N times
function decodeTileCompressedData(arr) {
	if (!Array.isArray(arr)) return [];
	const out = [];
	for (let i = 0; i < arr.length; i++) {
		const token = arr[i];
		if (token > 0) {
			// copy next `token` values literally
			for (let j = 1; j <= token; j++) {
				out.push(arr[i + j]);
			}
			i += token;
		} else if (token < 0) {
			const count = -token;
			const value = arr[++i];
			for (let k = 0; k < count; k++) out.push(value);
		} else {
			// token === 0: nothing to do
		}
	}
	return out;
}

console.log("Editor files");

// Read all folder names from ../../tilesets
const tilesetsPath = path.join(__dirname, '../../tilesets');
if (!fs.existsSync(tilesetsPath)) {
	console.error('Tilesets path does not exist:', tilesetsPath);
	process.exit(1);
}

const tilesetFolders = fs.readdirSync(tilesetsPath).filter(file => {
	return fs.statSync(path.join(tilesetsPath, file)).isDirectory();
});

const level_data = {};

for (const folder of tilesetFolders) {
	const tileset_path = path.join(tilesetsPath, folder, `${folder}.yy`);
	let tilesetObj = Yy.readSync(tileset_path);

	//if macropage is empty, skip
	if (tilesetObj.macroPageTiles.SerialiseHeight == 0) continue;

	const tileset = {};
	tileset.brush_height = tilesetObj.macroPageTiles.SerialiseHeight;
	tileset.brush_width = tilesetObj.macroPageTiles.SerialiseWidth;
	tileset.brush_tiles = decodeTileCompressedData(tilesetObj.macroPageTiles.TileCompressedData);

	level_data[folder] = tileset;
}

// Adjust the path as needed - this example goes up to project root then into datafiles
const outputPath = path.join(__dirname, '../../datafiles/editor_data.json');
fs.writeFileSync(outputPath, JSON.stringify(level_data, null, 2));

console.log(`Editor data created at: ${outputPath}`);

// ---- Resource browser tree (folders + sprites/objects/tilesets only) ----
//
// Pengu-lost-and-wanted.resource_order is NOT a complete listing - it's a
// sparse file of manual sort-order overrides (only ~70% of this project's
// folders/resources appear in it; anything left at default alphabetical
// order is simply absent). The .yyp's "Folders"/"resources" arrays ARE the
// complete listing, so that's the primary source here; resource_order is
// only consulted afterward to order the items that have a custom order.
// Folder nesting isn't recorded directly either - it's encoded in the
// folder path string itself (eg "folders/Objects/tool.yy" is nested under
// "folders/Objects.yy"), and which folder a RESOURCE belongs to is only in
// that resource's own .yy file ("parent" field) - so every relevant
// resource's .yy gets read once here, baking the result into a plain
// nested JSON the game can just json_load() at runtime with no parsing.

const projectRoot = path.join(__dirname, '../..');

function readTrailingCommaJson(filePath) {
	const raw = fs.readFileSync(filePath, 'utf8');
	// GameMaker's .yy/.yyp/.resource_order files are JSON with trailing commas
	return JSON.parse(raw.replace(/,(\s*[}\]])/g, '$1'));
}

const yyp = readTrailingCommaJson(path.join(projectRoot, 'Pengu-lost-and-wanted.yyp'));
const resourceOrder = readTrailingCommaJson(path.join(projectRoot, 'Pengu-lost-and-wanted.resource_order'));

// path -> custom order (only present for manually-reordered items)
const folderOrderByPath = new Map(resourceOrder.FolderOrderSettings.map(f => [f.path, f.order]));
const resourceOrderByPath = new Map(resourceOrder.ResourceOrderSettings.map(r => [r.path, r.order]));

const RESOURCE_TYPE_BY_PREFIX = {
	objects: 'object',
	sprites: 'sprite',
	tilesets: 'tileset',
	sounds: 'sound'
};

// folder path (eg "folders/Objects/tool.yy") -> working node
const folderNodes = new Map();
for (const f of yyp.Folders) {
	folderNodes.set(f.folderPath, {
		name: f.name,
		order: folderOrderByPath.get(f.folderPath),
		resources: [],
		folderChildren: new Map(),
	});
}

function parentFolderPath(folderPath) {
	const lastSlash = folderPath.lastIndexOf('/');
	if (lastSlash <= 'folders'.length) return null; // "folders/X.yy" -> top-level, no parent
	return folderPath.slice(0, lastSlash) + '.yy';
}

const rootFolderNodes = [];
for (const [folderPath, node] of folderNodes) {
	const parentPath = parentFolderPath(folderPath);
	if (parentPath && folderNodes.has(parentPath)) {
		folderNodes.get(parentPath).folderChildren.set(folderPath, node);
	} else {
		rootFolderNodes.push(node);
	}
}

// attach sprite/object/tileset resources to their owning folder
for (const r of yyp.resources) {
	const resourcePath = r.id.path;
	const type = RESOURCE_TYPE_BY_PREFIX[resourcePath.split('/')[0]];
	if (!type) continue; // not a sprite/object/tileset - ignored (sounds, scripts, rooms, etc)

	const resourceYyPath = path.join(projectRoot, resourcePath);
	if (!fs.existsSync(resourceYyPath)) continue;

	let resourceObj;
	try {
		resourceObj = Yy.readSync(resourceYyPath);
	} catch (e) {
		console.warn('Could not read resource .yy:', resourceYyPath, e.message);
		continue;
	}

	const parent = resourceObj.parent;
	if (!parent || !folderNodes.has(parent.path)) {
		console.warn('Resource has no known parent folder, skipped:', resourcePath);
		continue;
	}

	folderNodes.get(parent.path).resources.push({
		name: r.id.name,
		order: resourceOrderByPath.get(resourcePath),
		type,
	});
}

// sorts by custom order first (items without one fall back to alphabetical,
// sorted in after the explicitly-ordered ones), drops folders left with
// nothing relevant in them, and strips the order fields (only needed for
// sorting here, not at runtime)
function byOrderThenName(a, b) {
	if (a.order != null && b.order != null) return a.order - b.order;
	if (a.order != null) return -1;
	if (b.order != null) return 1;
	return a.name.localeCompare(b.name);
}

function finalizeFolder(node) {
	const childFolders = [];
	for (const child of node.folderChildren.values()) {
		const finalized = finalizeFolder(child);
		if (finalized) childFolders.push(finalized);
	}
	childFolders.sort(byOrderThenName);

	const resources = node.resources
		.slice()
		.sort(byOrderThenName)
		.map(r => ({ name: r.name, type: r.type }));

	if (resources.length === 0 && childFolders.length === 0) return null;

	return { name: node.name, order: node.order, resources, folders: childFolders };
}

function stripOrder(node) {
	delete node.order;
	node.folders.forEach(stripOrder);
	return node;
}

const resourceTree = rootFolderNodes
	.map(finalizeFolder)
	.filter(Boolean)
	.sort(byOrderThenName)
	.map(stripOrder);

const resourceTreeOutputPath = path.join(__dirname, '../../datafiles/editor/resource_tree.json');
fs.writeFileSync(resourceTreeOutputPath, JSON.stringify({ folders: resourceTree }, null, 2));

console.log(`Resource tree created at: ${resourceTreeOutputPath}`);