import { Yy } from '@bscotch/yy';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

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

	tilesetObj = tilesetObj.macroPageTiles;
	
	level_data[folder] = tilesetObj;
}

// Adjust the path as needed - this example goes up to project root then into datafiles
const outputPath = path.join(__dirname, '../../datafiles/level_data.json');
fs.writeFileSync(outputPath, JSON.stringify(level_data, null, 2));

console.log(`Level data file created at: ${outputPath}`);