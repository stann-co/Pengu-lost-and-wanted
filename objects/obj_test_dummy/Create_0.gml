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

var points_ = []
array_push(points_,new Verlet(0,-4,mass,1));
array_push(points_,new Verlet(0,-15,mass,0));
array_push(points_,new Verlet(0,-29,mass,0));
array_push(points_,new Verlet(0,-44,mass,0));

spine = new VerletRodPoints(points_)

default_draw = function(){
    draw_sprite_entity(spr_test_dummy,0,x,y+h_radius+2,1,1,0,-1,1);
	
	var seg_ = spine.segments[0];
	var x_ = seg_.p1.x;
	var y_ = seg_.p1.y;
	var dir_ = seg_.get_direction()-90;
	draw_sprite_entity(spr_test_dummy,1,x_,y_,1,1,dir_,-1,1);
	
	seg_ = spine.segments[1];
    x_ = seg_.p1.x;
	y_ = seg_.p1.y;
	dir_ = seg_.get_direction()-90;
	draw_sprite_entity(spr_test_dummy,2,x_,y_,1,1,dir_,-1,1);
	
	seg_ = spine.segments[2];
    x_ = seg_.p1.x;
	y_ = seg_.p1.y;
	dir_ = seg_.get_direction()-90;
    var subimg_ = state.state_is("meteor") ? 4 : 3;
	draw_sprite_entity(spr_test_dummy,subimg_,x_,y_,1,1,dir_,-1,1);
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
        
        draw_sprite_entity(spr_test_dummy,0,x,y+h_radius+2,1,1,0,-1,1);
    	
    	var seg_ = spine.segments[0];
    	var x_ = seg_.p1.x + stun_x;
    	var y_ = seg_.p1.y + stun_y;
    	var dir_ = seg_.get_direction()-90;
    	draw_sprite_entity(spr_test_dummy,1,x_,y_,1,1,dir_,-1,1);
    	
    	seg_ = spine.segments[1];
        x_ = seg_.p1.x + stun_x;
    	y_ = seg_.p1.y + stun_y;
    	dir_ = seg_.get_direction()-90;
    	draw_sprite_entity(spr_test_dummy,2,x_,y_,1,1,dir_,-1,1);
    	
    	seg_ = spine.segments[2];
        x_ = seg_.p1.x + stun_x;
    	y_ = seg_.p1.y + stun_y;
    	dir_ = seg_.get_direction()-90;
    	draw_sprite_entity(spr_test_dummy,4,x_,y_,1,1,dir_,-1,1);
    }
})

state.add_child("meteor_base","meteor",{
    draw: function(){
        
        
        //var trace_colors = [RED];
        
        //meteor trace
        if(global.t mod meteor_trace_offset == 0){
            var trace_ = {
                sprite_index: sprite_index,
                subimg: subimg,
                x: x,
                y: y,
                image_angle: image_angle
            }
            array_insert(meteor_trace_array,0,trace_);
            
            if(array_length(meteor_trace_array) > meteor_trace_count) array_resize(meteor_trace_array,meteor_trace_count);
        }
        
        //var fadeout = (super_speed_fadeout / super_speed_fadeout_time);
        
        //shader_set(sh_color);
        
        for (var i_ = array_length(meteor_trace_array)-1; i_ >= 0; --i_) {
            var trace_ = meteor_trace_array[i_];
            
            //shader_set_uniform_f(super_speed_u_color,
                //color_get_red(	 trace_.color)/255,
                //color_get_green( trace_.color)/255,
                //color_get_blue(	 trace_.color)/255
            //)
            //
            //shader_set_uniform_f(super_speed_u_intensity,1);
            
            //var alpha = (animcurve_read(ac_super_speed_alpha,0,i_/super_speed_trace_count) * fadeout)*invulnerable_alpha;
            gpu_set_colourwriteenable(1,1,1,0);
            draw_sprite_entity(trace_.sprite_index,trace_.subimg,trace_.x,trace_.y,1,1,trace_.image_angle,-1,1);
            gpu_set_colourwriteenable(1,1,1,1);
        }
        
        draw_sprite_entity(spr_test_dummy_full,1,x,y,1,1,image_angle,-1,1);
    }    
})