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

no_floor = function(){

}

touch_wall = function(){

}

hurt = function(){
	hurting = true;
	sprite_index = spr_flying;
	state.change("hurt");
}


state
.event_set_default_function("draw",function(){
	draw_sprite_ext(sprite_index,subimg,x,y,image_xscale,image_yscale,image_angle,-1,1);
})

.add("idle",{
	enter: function() {
		subimg = 0;
		input_h = image_xscale;
		sprite_index = spr_flying;
	},
	step: function() {
		subimg+= sprite_get_speed(sprite_index);
	},

})

state.change("idle")














