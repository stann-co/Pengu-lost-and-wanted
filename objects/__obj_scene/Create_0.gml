/// @description
queue = []
halt = false;

debug_text = []
debug_text_t = 0;

//text
text_source = ""; //text including switches and special characters
text_display = "";
text_t = 0;
text_margin = 16;
text_font = f_pixel;

text_speed_default = 0.5;
text_speed = text_speed_default;

text_skip = false;

textbox_height = 100;

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
        if(input_check_pressed("accept")){
            if(text_t < string_length(text_display)){
                text_skip = true;
            } else {
                halt = false;
                state.change("idle");
            }
        }
    },
    
    draw: function(){
        draw_sprite_stretched(spr_textbox,0,0,global.game_h-textbox_height,global.game_w,textbox_height);
        
        draw_set_valign(fa_top);
        draw_set_halign(fa_left);
        draw_set_font(text_font);
        
        var x_start_ = text_margin;
        var y_start_ = global.game_h-textbox_height+text_margin;
        
        var x_ = x_start_;
        var y_ = y_start_;
        
        var offset_x_ = 0;
        var offset_y_ = 0;
        
        var word_start_ = 1; //index current word starts
        var word_end_ = 1; //index current word end
        
        var escape_char_ = false;
        
        //effects
        var shake_ = false;
        var wave_ = false;
        var color_ = white;
        
        //text switches
        // & new line
        // ^1  wait a bit
        // [s] shake true
        // [w] wave true
        
        // [!s] shake false
        // [!w] wave false
        
        // [cred] color begin
        // / ignores character following this one so you can use special characters
        
        var char_ = ""
        
        for (var c = 1; c <= text_t; c++) {
            
            char_ = string_char_at(text_display,c);
            var cw_ = string_width(char_);
            var ch_ = string_height(char_);
            
            offset_x_ = 0;
            offset_y_ = 0;
            
            #region checks for effect triggers 
            if(!escape_char_){
                switch (char_) {
                    case "^": //pause
                        text_wait = real(string_char_at(text_display,c+1))*10;
                        text_display = string_delete(text_display,c,2);
                        continue;
                    case "&": //manual line break
                        x_ = x_start_;
                        y_ += ch_;
                        if(c == floor(text_t)) text_t++;
                        continue;
                    
                    case "/": //escape character
                        escape_char_ = true;
                        if(c == floor(text_t)) text_t++;
                        continue;
                    
                    case "[": //effect switch
                        #region effect switch
                        var switch_start_ = c;
                        var switch_end_ = 1;
                        for (var e = 2; e < 10; e++) { //looks ahead for ]
                        	if (string_char_at(text_display,c+e) == "]"){
                                switch_end_ = e+1;
                                break;
                            }
                        }
                        var effect_ = string_copy(text_display,c+1,switch_end_-2);
                        
                        switch (effect_) {
                            case "s":
                                shake_ = true;
                                break;
                            case "!s":
                                shake_ = false;
                                break;
                            case "w":
                                wave_ = true;
                                break;
                            case "!w":
                                wave_ = false;
                                break;
                            
                            //colors
                            case "cw":
                                color_ = white;
                                break;
                            case "cr":
                                color_ = red;
                                break;
                            case "cg":
                                color_ = green;
                                break;
                            case "cb":
                                color_ = blue;
                                break;
                            case "cy":
                                color_ = yellow;
                                break;
                        }
                    
                        if(c == floor(text_t)) text_t += switch_end_;
                        c += switch_end_-1;
                        continue; //goes to next character, when switch char is found
                    
                        #endregion
                }
            } else escape_char_ = false;
            
            #endregion
             
            //effects
            if (shake_){
                offset_x_ += random_range(-1,1);
                offset_y_ += random_range(-1,1);    
            }
            
            if(wave_){
                offset_y_ = sin(global.t*0.1+c*0.1)*2;    
            }
            
            draw_set_color(color_);
            draw_text(x_+offset_x_,y_+offset_y_,char_);
            draw_set_color(white);
            x_+=cw_;
        }
        
        if(text_skip){
            text_t+=10;
        } else {
            if(text_wait != 0){ //adds wait before progressing
                text_wait--;
            } else if (text_t <= string_length(text_display)){
                
                if(floor(text_t_delta) != floor(text_t)){
                    
                    if (char_ != " " && char_ != ""){
                        audio_play_sound(snd_text,0,false);
                    }
                }
                text_t_delta = text_t;
                text_t+= text_speed;
                
            }
        }
    }
});
#endregion