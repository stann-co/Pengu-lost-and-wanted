/// @description

// Inherit the parent event
event_inherited();


ps = part_system_create();
emitter = part_emitter_create(ps)
part_emitter_region(ps, emitter, -(sprite_width/2), (sprite_width/2), 0, 0, ps_shape_line, ps_distr_linear);
part_system_position(ps,x+(sprite_width/2),bbox_bottom);
part_system_automatic_draw(ps, false);

var part = particle_get_type(ps_winter_waterfall);
part_emitter_stream(ps,emitter,part,2);



spd			= -0.23;
xFrequency	= 22.0;
xSize		= 0.02;

uv_spd_x = 0;
uv_spd_y = -0.026;

 //Inspectron()
	//.Section("waterfall")
	//.Slider("spd",-0.5,0.5)
	//.Slider("xFrequency",0,100)
	//.Slider("xSize",0,0.1)
	//.Slider("uv_spd_x",-0.5,0.5)
	//.Slider("uv_spd_y",-0.5,0.5)
	//.render()