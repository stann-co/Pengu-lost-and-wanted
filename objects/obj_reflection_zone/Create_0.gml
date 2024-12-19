/// @description
image_angle = snap_to_90(image_angle)

width  = bbox_right-bbox_left;
height = bbox_bottom-bbox_top;

refl_surf = -1;

switch (image_angle) {
    case 0: //UP
        xscale = 1;
		yscale = -1;
		
		x_refl = 0;
		y_refl = height;
		
		x_draw = 0;
		y_draw = height;
		
        break;
    case 90: //Left
        xscale = -1;
		yscale = 1;
		
		x_refl = width;
		y_refl = 0;
		
		x_draw = width;
		y_draw = 0;
		
        break;
	case 180: //Down
        xscale = 1;
		yscale = -1;
		
		x_refl = 0;
		y_refl = -height;
		
		x_draw = 0;
		y_draw = height;
		
        break;
	case 270: //Right
        xscale = -1;
		yscale = 1;
		
		x_refl = -width;
		y_refl = 0;
		
		x_draw = width;
		y_draw = 0;
        break;
}
		
switch(distortion) {
	case "none":
		break;
	case "waterfall":
	
		spd = 0.13;
		frequency = 200;
		size = 0.005;
		
		u_speed = shader_get_uniform(sh_waterfall,"u_speed");
		u_frequency = shader_get_uniform(sh_waterfall,"u_frequency");
		u_size = shader_get_uniform(sh_waterfall,"u_size");
		u_time = shader_get_uniform(sh_waterfall,"u_time");

		 //Inspectron()
			//.Section("reflection")
			//.Slider("spd",-0.5,0.5)
			//.Slider("frequency",0,200)
			//.Slider("size",0,1)
			//.render()

		break;
}


