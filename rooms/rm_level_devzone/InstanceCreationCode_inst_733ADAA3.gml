trigger = function(){
    
    s_control(false)
    s_text("hey^2 you see that [w][cy]car[cw][!w] ?")
    s_wait(1)
    s_act(function(){
        var camera_pos = inst_F632018_camera_pos1;
        global.camera.follow = noone;
        global.camera.move(camera_pos.x,camera_pos.y,game_speed*0.5);    
    })
    s_wait(2) 
    
    s_act(function(){ // pengu shocked
        call_later(3,time_source_units_seconds,function(){
            splash_sequence(Seq_pengu_shock);
        })
    })
    
    s_text_font(f_danger)
    s_text_speed(0.2)
    s_text("[s]I downloaded it....")
    s_text_end()
    s_text_font(f_pixel)
    s_text_speed(1)
    
    
    s_wait(1)
    

    s_act(function(){
        global.camera.move(obj_pengu.x,obj_pengu.y,game_speed);
    })
    s_wait_condition(function(){
        return (global.camera.x == obj_pengu.x && global.camera.y == obj_pengu.y)
    })
    s_act(function(){
        global.camera.follow = obj_pengu;
    })
    s_control(true);
    
    
    
    instance_destroy();
    
}