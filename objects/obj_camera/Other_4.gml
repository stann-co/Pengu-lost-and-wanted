#region Layer code
var levels_data = json_load("level_data.json");
var level_name = room_get_name(room);

global.level_data = struct_get_chained(levels_data,level_name);
if(global.level_data == undefined) global.level_data = {}

#endregion