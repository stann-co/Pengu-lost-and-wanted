/// @description splash layer surface
splash_surface = -1;
splash_layer = layer_create(-999);

layer_script_begin(splash_layer,function(){
    if (event_type == ev_draw) {
        if (event_number == ev_draw_normal){
            if(!surface_exists(splash_surface)){
                splash_surface = surface_create(global.game_w,global.game_h);
            }
            surface_set_target(splash_surface);
            draw_clear_alpha(black,0);
            gpu_set_blendmode_ext(bm_one,bm_zero);
        }
    }
})
layer_script_end(splash_layer,function(){
    if (event_type == ev_draw) {
        if (event_number == ev_draw_normal){
            gpu_set_blendmode(bm_normal);
            surface_reset_target();
        }
    }
})

sequence = layer_sequence_create(splash_layer,global.game_w/2,global.game_h/2,sequence_element);
