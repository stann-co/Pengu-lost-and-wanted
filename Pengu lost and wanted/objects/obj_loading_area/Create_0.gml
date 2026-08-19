//everything within the loading areas bounds 
//gets loaded together

instance_activate_region(bbox_left,bbox_top,bbox_left+sprite_width,bbox_top+sprite_height,true);

var list_ = ds_list_create();
collision_rectangle_list(bbox_left,bbox_top,bbox_right,bbox_bottom, all, false, true, list_, false);

ds_list_add(list_,id);

activation_link_list(list_);
ds_list_destroy(list_);

