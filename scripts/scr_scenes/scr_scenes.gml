
room_instance_add(rm_init,0,0,obj_scene)
global.scene = obj_scene

///@function s_wait(_seconds)
///@description adds wait in seconds
///@param seconds
function s_wait(_seconds = 1){
    
    with {_seconds} array_push(global.scene.queue,function(){ 
        global.scene.halt = true;
        call_later(_seconds,time_source_units_seconds,function(){
            global.scene.halt = false;
        })    
    });
}

///@function s_wait_condition(_condition)
///@description adds wait condition must be true to continue
///@param bool return func
function s_wait_condition(_condition){
    with {_condition} array_push(global.scene.queue,function(){ 
        global.scene.halt = true;
        loop_ = call_later(1,time_source_units_frames,function(){
            if(_condition()){
                global.scene.halt = false;
                call_cancel(loop_);
            }
        },true);
    });
}


///@function s_control(_bool)
///@description disables or enables control
///@param boolean
function s_control(_bool){
    with {_bool} array_push(global.scene.queue,function(){
        global.control = _bool;    
    });
}

///@function s_debug_message(_text)
///@description writes debug message to screen
///@param text
function s_debug_message(_text){
    with {_text} array_push(global.scene.queue,function(){
        show_debug_message(_text);
        global.scene.debug_text_t = GAME_SPEED*4;
        array_insert(global.scene.debug_text,0,_text);
        
    });
}

///@function s_act(_func)
///@description executes function
///@param _func
function s_act(_func){
    array_push(global.scene.queue,_func);
}

///@function s_text(_text)
///@description textbox
///@param _text
function s_text(_text){
    
    with {_text} array_push(global.scene.queue,function(){
        global.scene.halt = true;
        global.scene.text_source = _text;
        global.scene.state.change("textbox");
    });
}

///@function s_text_font(_font)
///@description set font
///@param _font
function s_text_font(_font){
    with {_font} array_push(global.scene.queue,function(){
        global.scene.text_font = _font;
        
    });
}

///@function s_text(_text)
///@description textbox
///@param _text
function s_text_end(){
    array_push(global.scene.queue,function(){
        global.scene.state.change("idle");
    });
}

///@function s_text_speed(_speed)
///@description textbox speed
///@param _speed
function s_text_speed(_speed = 1){
     with {_speed} array_push(global.scene.queue,function(){
        global.scene.text_speed = _speed * global.scene.text_speed_default;
    });
}