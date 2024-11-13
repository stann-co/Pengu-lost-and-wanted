/// @description

var x_ = global.camera.get_x();
var y_ = global.camera.get_y();
	
	if(!surface_exists(srf_tile)){
		srf_tile = surface_create(global.camera.width,global.camera.height);
	}
	
	if(!surface_exists(srf_normal)){
		srf_normal = surface_create(global.camera.width,global.camera.height,surface_rg8unorm);
	}
	
	if(!surface_exists(srf_roughness)){
		srf_roughness = surface_create(global.camera.width,global.camera.height,surface_r8unorm);
	}
	
	//surface_set_target(srf_normal);
	//	if(tileset_n == -1){
	//		draw_clear(normal_blank);
	//	} else {
	//		tilemap_tileset(tilemap,tileset_n);
	//		draw_tilemap(tilemap,-x_,-y_);
	//	}
	//surface_reset_target();
	
	//surface_set_target(srf_roughness);
	//	if(tileset_r == -1){
	//		draw_clear(black);
	//	} else {
	//		tilemap_tileset(tilemap,tileset_r);
	//		draw_tilemap(tilemap,-x_,-y_);
	//	}
	//surface_reset_target();
	
	surface_set_target(srf_tile);
		draw_clear_alpha(black,0);
		tilemap_tileset(tilemap,tileset);
		draw_tilemap(tilemap,-x_,-y_);
	surface_reset_target();
	
	
	
	draw_surfaces_cubemap(srf_tile,x_,y_,0,0,srf_normal,srf_roughness,spr_crt,normal_strength,roughness_strength,scale,offset_scale);
	
	