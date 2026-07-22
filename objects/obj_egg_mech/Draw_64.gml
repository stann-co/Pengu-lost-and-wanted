/// @description
if (!surface_exists(srf_gui)) srf_gui = surface_create(global.game_w,global.game_h);

surface_set_target(srf_gui);


surface_reset_target();


draw_surface(srf_gui,0,0);

state.draw_gui()