/// @description
x_speed = 0;
y_speed = 0;
airborne = false;
ground_angle = 0;
ground_spd = 0;
subimg = 0;
anim_speed = 1; //set to -1 to reverse
collision_layer = COLLISION_LAYERS.A

image_to_ground_angle = false;

facing = 1; // +1 = right | -1 = left

w_radius = 6;
h_radius = 6;

slope_factor = 0.123;

gravity_force = 0.2251;

//scale & squishing
scale_x = 1;
scale_y = 1;
squish_x_scale = 1;
squish_y_scale = 1;
squish_x_origin = 0; // -1 left | 1 right
squish_y_origin = 0; // -1 top  | 1 bottom

squishing = false;
squishing_t = 0;
squishing_duration = 0;

//hurt flash & shake
hurt_shake_x = 0;
hurt_shake_y = 0;
hurt_shake_radius = 10;
hurt_shake = 0; //when not 0 there's shaking and flashing

hurt_shake_start = function(_shake_radius){
    hurt_shake_radius = _shake_radius;
    hurt_shake = GAME_SPEED * 0.5;
    
    var val_ = hurt_shake_radius * (hurt_shake / 30)
    hurt_shake_x = irandom_range(-val_,val_);
    hurt_shake_y = irandom_range(-val_,val_);
}

//@Function draw_sprite_ext with extra entity specific features
draw_sprite_entity = function(_sprite,_subimg,_x,_y,_xscale,_yscale,_rot,_color,_alpha){
    if(hurt_shake != 0){
        //every x frames a new stun pos is set
        if(hurt_shake mod 2 == 0){
            var val_ = hurt_shake_radius * (hurt_shake / 30)
            hurt_shake_x = irandom_range(-val_,val_);
            hurt_shake_y = irandom_range(-val_,val_);
        }
        
        if(sin(hurt_shake*0.5) > 0){
            //feather ignore once GM2003
            shader_set(sh_stunned);
        }
        

        
    } else {
        hurt_shake_x = 0;
        hurt_shake_y = 0;
    }
    
    var x_squish_ = (x + (_x - x)*scale_x)+(w_radius*(1-scale_x)*squish_x_origin);
    var y_squish_ = (y + (_y - y)*scale_y)+(h_radius*(1-scale_y)*squish_y_origin);
    
    draw_sprite_ext(_sprite,_subimg,x_squish_+hurt_shake_x,y_squish_+hurt_shake_y,scale_x*_xscale,scale_y*_yscale,_rot,_color,_alpha);
    
    if(hurt_shake != 0) shader_reset();
}

///@function squish()
///@param _scale_x
///@param _scale_y
///@param _duration
squish = function(_scale_x,_scale_y,_duration = GAME_SPEED*0.4){
	squish_x_scale = _scale_x;
	squish_y_scale = _scale_y;
    squish_x_origin = 0;
    squish_y_origin = 1;
	squishing = true;
	squishing_t = 0;
	squishing_duration = _duration;
}

default_draw = function(){
    //when rotated on slopes, appears a few pixels 1off
    var slope_offset_y_ = 0;
	if(!airborne) slope_offset_y_ = abs(dsin(ground_angle*2)) * sign(dcos(ground_angle)) * 4 //the pixel offset when at a 45deg angle
	
    draw_sprite_entity(sprite_index,subimg,x,y+slope_offset_y_,facing,1,image_angle,-1,1);
}
