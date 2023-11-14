//everything within the loading areas bounds 
//gets loaded together

instance_activate_region(bbox_left,bbox_top,bbox_left+sprite_width,bbox_top+sprite_height,true);

var _list = ds_list_create();
collision_rectangle_list(bbox_left,bbox_top,bbox_right,bbox_bottom, all, false, true, _list, false);

ds_list_add(_list,id);

activation_link_list(_list);
ds_list_destroy(_list);

