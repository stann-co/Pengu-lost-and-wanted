/// @description

// Inherit the parent event
event_inherited();

w_radius = 22;
h_radius = 24;
airborne = true;

top_speed = 20;

gravity_force = 0.2251;
floor_friction = 0.99;

rotation = 0;
rot_speed = 0;

hurt = function(){
    rot_speed = random_range(-10,10);
}

//3D

ball = new BBMOD_Model("3D/kat_smart.bbmod").freeze();
/// Feather ignore once GM2017
ball.Materials[@ 0] = new material()

depth = global.depth_a;

default_draw = function(){
    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);
    
    var scale_ = 64;
    
    new BBMOD_Matrix()
        .RotateX(-90)
        .RotateY(rotation)
    	.scale_(scale_,scale_,scale_)
    	.Translate(x, y, depth)
    	.ApplyWorld();
    ball.submit();
    new BBMOD_Matrix().ApplyWorld();
    
    shader_reset();
    
    gpu_set_ztestenable(false);
    gpu_set_zwriteenable(false);
}

state.add("idle",{

    enter:function(){

        
    },
    step:function(){
        if(airborne){
            y_speed += gravity_force;
        } else {
		    x_speed *= floor_friction;
            rot_speed *= floor_friction;
        }

        if(mouse_check_button(mb_left)){
            airborne = true;
        	var mx_ = global.camera.get_mouse_x();
        	var my_ = global.camera.get_mouse_y();
            
            x_speed = clamp(mx_-x,-top_speed,top_speed);
            y_speed = clamp(my_-y,-top_speed,top_speed);
        }
        
    }

})
