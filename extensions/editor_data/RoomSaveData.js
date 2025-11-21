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

import { Yy } from '@bscotch/yy';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const roomName = process.argv[2];

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const roomdata_path = path.join(__dirname, "temp_room_data.json");

const roomDataObj = Yy.readSync(roomdata_path);

let roomFileObj = Yy.readSync(path.join(__dirname, `../../rooms/${roomName}/${roomName}.yy`));

/* width = roomDataObj.width;
height = roomDataObj.height;
layers = roomDataObj.layers; */

console.log(roomFileObj);
//uses new data to overwrite

Yy.writeSync(path.join(__dirname, `../../rooms/${roomName}/${roomName}2.yy`), roomFileObj);

//const outputPath = path.join(__dirname, 'test.txt');
//fs.writeFileSync(outputPath, "is this working?");