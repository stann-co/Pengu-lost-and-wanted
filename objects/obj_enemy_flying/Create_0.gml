/// @description
event_inherited();

vec_rt = new Vector2(0,0); //right
vec_lt = new Vector2(0,0); //left
vec_rb = new Vector2(0,0); //right
vec_lb = new Vector2(0,0); //left

vec_b = new Vector2(0,0); //bottom

top_speed = 1;
w_radius = 12;
h_radius = 7;

fly_offset = 0;

no_floor = function(){

}

touch_wall = function(){

}

hurt = function(){
	hurting = true;
	sprite_index = spr_tigerbara_hurt;
	state.change("hurt");
	var sound = audio_play_sound(snd_seal_hurt,1,false);
	audio_sound_pitch(sound,pitch_change(random_range(1.3,1.6)));	
}


state
.event_set_default_function("draw",function(){
	draw_sprite_ext(sprite_index,subimg,x,y+fly_offset,image_xscale,image_yscale,image_angle,-1,1);
})

.add("idle",{
	enter: function() {
		subimg = 0;
		input_h = image_xscale;
		sprite_index = spr_tigerbara_idle;
	},
	step: function() {
		subimg+= sprite_get_speed(sprite_index);
		fly_offset = sin(global.t*0.1)*4
	},

})

state.change("idle")














