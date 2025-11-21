function RoomSaveData(){
    show_debug_message(GM_project_filename)
    
    var path_ = string_replace(GM_project_filename,"Pengu-lost-and-wanted.yyp","extensions/editor_data/");
    
    
    var room_info_ = room_get_info(room,false,false,true,true,true);
    
    show_debug_message(room_info_);
    json_save(path_+"temp_room_data.json",room_info_);
    execute_shell_simple("RoomSaveData.bat",room_get_name(room),"open",1,path_);
}