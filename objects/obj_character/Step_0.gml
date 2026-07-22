/// @description


if(CAN_MOVE){
    
    //animate subimg
    if(sprite_index != -1){
        subimg+= (sprite_get_speed(sprite_index)*anim_speed);
    }
    
    //squish scale_x & scale_y    
    if(squishing){
        if(squishing_t != squishing_duration){
            var val_ = animcurve_read(ac_squish,0,squishing_t/squishing_duration)
            
            scale_x = lerp(1,squish_x_scale,val_);
            scale_y = lerp(1,squish_y_scale,val_);
            
            squishing_t++;
        } else squishing = false;	
    }
    
    if(image_to_ground_angle){
        image_angle += angle_difference(ground_angle,image_angle)*0.5;
    }
}

if(hurt_shake != 0) hurt_shake--
