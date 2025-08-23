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
	
    draw_set_color(white)
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

        //if(mouse_check_button(mb_left)){
            //airborne = true;
        	//var mx = global.camera.get_mouse_x();
        	//var my = global.camera.get_mouse_y();
            //
            //x_speed = clamp(mx-x,-top_speed,top_speed);
            //y_speed = clamp(my-y,-top_speed,top_speed);
        //}
    }
})

.add("stunned",{
    enter:function(){
        airborne = true
        
        stun_x = irandom_range(-stun_radius,stun_radius);
        stun_y = irandom_range(-stun_radius,stun_radius);
    },
    step:function (){
        if(meteor) state.change("meteor");
        else state.change("launched");
        
    },
    draw:function (){
        //every x frames a new stun pos is set
        if(global.freeze_duration mod 2 == 0){
            var val = stun_radius * ((global.freeze_duration) / 30)
            stun_x = irandom_range(-val,val);
            stun_y = irandom_range(-val,val);
        }
        
        if(sin(global.freeze_duration*0.5) > 0){
            shader_set(sh_stunned);
        }
         
        draw_sprite(spr_test_dummy,0,x+stun_x,y+h_radius+2+stun_y);
        
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
    	draw_sprite_ext(spr_test_dummy,3,x_,y_,1,1,dir_,-1,1);

        shader_reset()
    }
})
