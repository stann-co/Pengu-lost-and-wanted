/// @description

// Inherit the parent event
event_inherited();

w_radius = 9;
h_radius = 20;
airborne = true;

top_speed = 20;

gravity_force = 0.2251;
floor_friction = 0.91;

mass = 20;
drag = 0.01;

meteor_trace_array = [];
meteor_trace_offset = 1;
meteor_trace_count = 6;

var points_ = []
array_push(points_,new verlet(0,-4,mass,1));
array_push(points_,new verlet(0,-15,mass,0));
array_push(points_,new verlet(0,-29,mass,0));
array_push(points_,new verlet(0,-44,mass,0));

spine = new verlet_rod_points(points_)

default_draw = function(){
    draw_sprite(spr_test_dummy,0,x,y+h_radius+2);
	
	var seg = spine.segments[0];
	var x_ = seg.p1.x;
	var y_ = seg.p1.y;
	var dir_ = seg.get_direction()-90;
	draw_sprite_ext(spr_test_dummy,1,x_,y_,1,1,dir_,-1,1);
	
	seg = spine.segments[1];
    x_ = seg.p1.x;
	y_ = seg.p1.y;
	dir_ = seg.get_direction()-90;
	draw_sprite_ext(spr_test_dummy,2,x_,y_,1,1,dir_,-1,1);
	
	seg = spine.segments[2];
    x_ = seg.p1.x;
	y_ = seg.p1.y;
	dir_ = seg.get_direction()-90;
    var subimg = state.state_is("meteor") ? 4 : 3;
	draw_sprite_ext(spr_test_dummy,subimg,x_,y_,1,1,dir_,-1,1);
}

state.add("idle",{

    enter:function(){

    },
    step:function(){
        if(airborne){
            y_speed += gravity_force;
        } else {
		    x_speed *= floor_friction;
        }
    }
})
state.add_child("stunned_base","stunned",{
    draw:function (){
        state.inherit()
        
        draw_sprite(spr_test_dummy,0,x,y+h_radius+2);
    	
    	var seg = spine.segments[0];
    	var x_ = seg.p1.x + stun_x;
    	var y_ = seg.p1.y + stun_y;
    	var dir_ = seg.get_direction()-90;
    	draw_sprite_ext(spr_test_dummy,1,x_,y_,1,1,dir_,-1,1);
    	
    	seg = spine.segments[1];
        x_ = seg.p1.x + stun_x;
    	y_ = seg.p1.y + stun_y;
    	dir_ = seg.get_direction()-90;
    	draw_sprite_ext(spr_test_dummy,2,x_,y_,1,1,dir_,-1,1);
    	
    	seg = spine.segments[2];
        x_ = seg.p1.x + stun_x;
    	y_ = seg.p1.y + stun_y;
    	dir_ = seg.get_direction()-90;
    	draw_sprite_ext(spr_test_dummy,4,x_,y_,1,1,dir_,-1,1);
        
        //reseting after shader was set in parent draw event
        shader_reset()
    }
})

state.add_child("meteor_base","meteor",{
    draw: function(){
        
        
        //var trace_colors = [red];
        
        //meteor trace
        if(global.t mod meteor_trace_offset == 0){
            var trace = {
                sprite_index: sprite_index,
                subimg: subimg,
                x: x,
                y: y,
                //scale_x: scale_x,
                //scale_y, scale_y,
                //mirror: mirror,
                image_angle: image_angle
                //color: super_speed_colors[(global.t / meteor_trace_offset) mod array_length(super_speed_colors)]
            }
            array_insert(meteor_trace_array,0,trace);
            
            if(array_length(meteor_trace_array) > meteor_trace_count) array_resize(meteor_trace_array,meteor_trace_count);
        }
        
        //var fadeout = (super_speed_fadeout / super_speed_fadeout_time);
        
        //shader_set(sh_color);
        
        for (var i = array_length(meteor_trace_array)-1; i >= 0; --i) {
            var trace = meteor_trace_array[i];
            
            //shader_set_uniform_f(super_speed_u_color,
                //color_get_red(	 trace.color)/255,
                //color_get_green( trace.color)/255,
                //color_get_blue(	 trace.color)/255
            //)
            //
            //shader_set_uniform_f(super_speed_u_intensity,1);
            
            //var alpha = (animcurve_read(ac_super_speed_alpha,0,i/super_speed_trace_count) * fadeout)*invulnerable_alpha;
            gpu_set_colourwriteenable(1,1,1,0);
            draw_sprite_ext(trace.sprite_index,trace.subimg,trace.x,trace.y,1,1,trace.image_angle,-1,1);
            gpu_set_colourwriteenable(1,1,1,1);
        }
        //shader_reset();
                
        
        
        
        
        
        
        
        
        draw_sprite_ext(spr_test_dummy_full,1,x,y,1,1,image_angle,-1,1);
    }    
})