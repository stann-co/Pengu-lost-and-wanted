/// @description
var parralax_ = struct_get_chained(global.room_data,"layers",name,"parralax") ?? 0;
var offset_x_ = floor(global.camera.get_x() * parralax_);
var offset_y_ = floor(global.camera.get_y() * parralax_);
if(type == LAYER_TYPE.TILEMAP){
	draw_tilemap(tilemap,offset_x_,offset_y_);
}
else if(type == LAYER_TYPE.ASSET){
	var elements_ = layer_get_all_elements(layer_id);
	
	for (var i_ = 0; i_ < array_length(elements_); i_++) {
		var element_ = elements_[i_];
		var sprite_ = layer_sprite_get_sprite(element_);
		var subimg_ = layer_sprite_get_index(element_);
		var x_ = layer_sprite_get_x(element_);
		var y_ = layer_sprite_get_y(element_);
		var scale_x_ = layer_sprite_get_xscale(element_);
		var scale_y_ = layer_sprite_get_yscale(element_);
		var alpha_ = layer_sprite_get_alpha(element_);
		var rot_ = layer_sprite_get_angle(element_);
		var color_ = layer_sprite_get_blend(element_);
		draw_sprite_ext(sprite_,subimg_,x_+offset_x_,y_+offset_y_,scale_x_,scale_y_,rot_,color_,alpha_);
	}
}

//var camx_ = global.camera.get_x();   
//var camy_ = global.camera.get_y();
//
//var tileset_ = tilemap_get_tileset(tilemap);
//var tileset_name_ = tileset_get_name(tileset_);
//var uvs_ = tileset_get_uvs(tileset_)
//
//var margin_ = 16;

//#region diffuse surface
//if(!surface_exists(srf_diffuse)){
    //srf_diffuse = surface_create(global.game_w+margin_*2,global.game_h+margin_*2);
//}
//surface_set_target(srf_diffuse);
//draw_clear_alpha(BLACK,0);
//
//draw_tilemap(tilemap,-camx_+margin_,-camy_+margin_);
//
//surface_reset_target();
//
//#endregion
//
//#region get normal roughness depth coord offsets
//
//if(!surface_exists(srf_maps)){
    //srf_maps = surface_create(global.game_w+margin_*2,global.game_h+margin_*2);
//}
//surface_set_target(srf_maps);
//
//draw_clear_alpha(BLACK,0);
//
//shader_set(sh_uv_offset);
//
////gets normal sprite coordinate offset
//var tileset_maps_ = asset_get_index(tileset_name_+"_maps");
//if(tileset_maps_ != -1){
	//var uvs_maps_ = tileset_get_uvs(tileset_maps_)
	//shader_set_uniform_f(u_texcoord_uv,uvs_[0]-uvs_maps_[0],uvs_[1]-uvs_maps_[1]);
//} else shader_set_uniform_f(u_texcoord_uv,-1);
//
//gpu_set_blendmode_ext(bm_one,bm_zero);
//
//draw_tilemap(tilemap,-camx_+margin_,-camy_+margin_);
//gpu_set_blendmode(bm_normal);
//
//shader_reset();
//
//surface_reset_target();
//
//#endregion
//
//shader_set(sh_tilemap_fx);
//
//var fx_tex_ = surface_get_texture(srf_maps);
//texture_set_stage(s_tilemap_fx,fx_tex_);
//
//var shine_tex_ = sprite_get_texture(spr_reflection_2,0);
//
//texture_set_stage(s_texture,shine_tex_);
//
//shader_set_uniform_f(u_depth,depth_);
//shader_set_uniform_f(u_roughness,roughness);
//shader_set_uniform_f(u_normal,normal);
//
//shader_set_uniform_f(u_cam_offset,camx_-margin_,camy_-margin_);
//
//shader_set_uniform_f(u_texture_offset_scale,texture_offset_scale);
//shader_set_uniform_f(u_texture_scale,texture_scale);
//
//draw_surface(srf_diffuse,camx_-margin_,camy_-margin_);
//
//shader_reset();

