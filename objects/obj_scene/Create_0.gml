/// @description
queue = []
halt = false;

debug_text = []
debug_text_t = 0;

//text
text = ""
text_writing = false
text_font = "f_pixel";
text_speed = 1;

//textbox
textbox_w = 346;
textbox_h = 52;
portrait_w = 60;

//scribble
typist = scribble_typist()
.in(0.2, 0)
.sound([snd_keypress1,snd_keypress2,snd_keypress3,snd_keypress4],300,0.9,1.1,0.2)
.function_on_complete(function(){
    text_writing = false;
})

scribble_font_set_default("f_pixel");

scribble_add_macro("w",function(_wait = "4"){
	var wait_ = int64(_wait) * 100;
	return $"[delay,{wait_}]"
})

scribble_typists_add_event("mute",function(_element, _parameter_array, _character_index){
    //typist.set_sound_tag_gain(0);
})

state = new SnowState("idle");

state.add("idle",{
    
});

#region textboxes
state.add("textbox",{
    
    enter: function (){

    },
    
    step: function(){
        
        if(InputPressed(INPUT_VERB.ACCEPT)){
			if(text_writing){
				typist.skip();	
			} else {
				halt = false;
			}
        }
    },
    
    draw: function(){
		var x_ = (global.gui_w-textbox_w)/2;
		var y_ = global.gui_h-textbox_h-6;
		
		var margin_ = 6;
		
        draw_sprite_stretched(spr_textbox,0,x_,y_,textbox_w,textbox_h);
		draw_sprite_stretched(spr_textbox_bubble,0,x_+portrait_w+margin_,y_+margin_,textbox_w-portrait_w-margin_*2,textbox_h-margin_*2);
		draw_sprite(spr_textbox_bubble_tail,0,x_+portrait_w+margin_,y_+textbox_h-margin_); //draws textbox tail
		
		scribble(text)
		.scale(1.1)
		.wrap(textbox_w-portrait_w,textbox_h)
		.starting_format(text_font,WHITE)
		.align(fa_left,fa_top)
		.padding(margin_*2,margin_,margin_*2,margin_)
		.draw(x_+portrait_w, y_, typist)
		
    }
});
#endregion