/// @description

refl_surf = -1;
u_tint = shader_get_uniform(sh_reflection,"u_tint");
u_brightness = shader_get_uniform(sh_reflection,"u_brightness");
u_scale = shader_get_uniform(sh_reflection,"u_scale");
u_distortion = shader_get_uniform(sh_reflection,"u_distortion");
u_size = shader_get_uniform(sh_reflection,"u_size");

u_speed = shader_get_uniform(sh_reflection,"u_speed");
u_time = shader_get_uniform(sh_reflection,"u_time");
		
//switch(distortion_type) {
//	case "none":
//		break;
//	case "waterfall":
		
//		break;
//	case "ice":
//		break;
//}




		//Inspectron()
		//	.Section("ice")
		//	.Slider("scale",0,1)
		//	.Slider("distortion",0,1)
		//	.render()