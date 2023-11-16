state.draw();

if(global.debug && state.state_is("fall")){
	draw_set_color(red);
	draw_sensor(x,y,vec_b,0,h_radius);
	draw_set_color(white);
}

