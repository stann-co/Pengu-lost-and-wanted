/// @description
queue = []
halt = false;

debug_text = []
debug_text_t = 0;

//text
text = ""
text_writing = false
text_font = f_pixel;
text_speed = 1;

//textbox
textbox_w = 346;
textbox_h = 52;

//scribble
typist = scribble_typist()
.in(0.2, 0)
.sound([snd_keypress1,snd_keypress2,snd_keypress3,snd_keypress4],300,0.9,1.1,0.2)
.function_on_complete(function(){
    text_writing = false;
})

scribble_font_set_default("f_pixel");

scribble_typists_add_event("mute",function(_element, _parameter_array, _character_index){
    //typist.set_sound_tag_gain(0);
})

state = new SnowState("idle");

state.add("idle",{
    
});

#region textboxes
state.add("textbox",{
    
    enter: function (){
        text_t = 0; 
        text_t_delta = 0;
        text_wait = 0;
        text_skip = false;
        text_display = text_source;
    },
    
    step: function(){
        
        if(InputPressed(INPUT_VERB.ACCEPT)){
            if(text_t < string_length(text_display)){
                text_skip = true;
            } else {
                halt = false;
                state.change("idle");
            }
        }
    },
    
    draw: function(){
        draw_set_alpha(0.8);
        draw_sprite_stretched(spr_textbox,0,0,global.game_h-textbox_height,global.game_w,textbox_height);
        draw_set_alpha(1);
        
        //simplify textboxes using scribble
    }
});
#endregion