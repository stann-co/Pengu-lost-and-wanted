/// @description

global.gui_draw = false;

scribble_font_set_default("f_pixel");



typist = scribble_typist()
.in(0.2, 0)
.sound([snd_keypress1,snd_keypress2,snd_keypress3,snd_keypress4],300,0.9,1.1,0.2)
.function_on_complete(function(){
    writing = false;
})


scribble_typists_add_event("mute",function(_element, _parameter_array, _character_index){
    //typist.set_sound_tag_gain(0);
})

writing = false;

t = 0;
fade = 1;
pause_durtaion = GAME_SPEED;
fade_duration = GAME_SPEED;

text_array = [
    lexicon_text("intro.1"),
    lexicon_text("intro.2"),
    lexicon_text("intro.3"),
    lexicon_text("intro.4"),
    lexicon_text("intro.5"),
    lexicon_text("intro.6"),
]

slide = 0; //which image and text to use

text = "";

state = new SnowState("start")

state.add("start",{
    enter: function(){
        t = 0;
    },
    step: function(){
        if(t >= pause_durtaion){
            text = text_array[slide]
            state.change("writing")    
        } else t++;
    }    
})

state.add("writing",{
    enter: function(){
        writing = true;
        t = 0;
    },
    step: function(){
        if(!writing){
            if(t >= pause_durtaion){
                state.change("fade_out")    
            } else t++;
            
        }
    }    
})

state.add("fade_out",{
    enter: function(){
        t = 0;
    },
    step: function(){
        
        fade = lerp(1,0,t/fade_duration);
        
        if(t >= fade_duration){
            if(slide < array_length(text_array)-1){
                
                slide++
                
                text = text_array[slide];
                
                state.change("fade_in")    
            } else {
                show_debug_message("done!")
            }
            
        } else t++;
        
    }
})

state.add("fade_in",{
    enter: function(){
        t = 0;
    },
    step: function(){
        
        fade = lerp(0,1,t/fade_duration);
        
        if(t >= fade_duration){
            state.change("writing")
        } else t++;
        
    }
})