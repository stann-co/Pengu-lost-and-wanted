/// @description

var scale_ = parralax_effective(parralax, tile_size) / tile_size;

var view_ = matrix_get(matrix_view);

var new_view_ = matrix_multiply(view_,matrix_build(0,0,0,0,0,0,scale_,scale_,1));

//pixel-snap the resulting offset - to reduce shimmer
new_view_[12] = round(new_view_[12]);
new_view_[13] = round(new_view_[13]);

//on top of the snap above - nudges sampling off exact texel-atlas edges,
//where floating point rounding can flip inconsistently frame to frame.
var pixel_bias_ = 0.1 / scale_;
new_view_[12] += pixel_bias_;
new_view_[13] += pixel_bias_;

matrix_set(matrix_view,new_view_);

//Draws tilemap using specified shader, if shader_function is set
if(shader_function != undefined){
	shader_function();
	draw_tilemap(tilemap,0,0);
	shader_reset();
	reset_draw();
} else {
	draw_tilemap(tilemap,0,0);
}







matrix_set(matrix_view,view_);


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

