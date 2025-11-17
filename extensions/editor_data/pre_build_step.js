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