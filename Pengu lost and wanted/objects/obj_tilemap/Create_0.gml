tilemap = layer_tilemap_get_id(layer_name);
tile_size = tilemap_get_tile_width(tilemap);

layer_set_visible(layer_name,false);

shader_function = undefined;


if	   (layer_name == "collision_A") collision_layer = COLLISION_LAYERS.A;
else if(layer_name == "collision_B") collision_layer = COLLISION_LAYERS.B;
else if(layer_name == "collision_C") collision_layer = COLLISION_LAYERS.C;

if (variable_instance_exists(id,"collision_layer")){
	shader_function = function(){
		var u_layer = shader_get_uniform(sh_collision,"u_layer");
		var u_active = shader_get_uniform(sh_collision,"u_active");
		var u_show = shader_get_uniform(sh_collision,"u_show");
		
		shader_set(sh_collision);
		shader_set_uniform_i(u_layer,collision_layer);
		shader_set_uniform_i(u_active,ACTIVE_PLAYER_COLLISION_LAYER);
		shader_set_uniform_i(u_show,global.show_collisions);
	}
}