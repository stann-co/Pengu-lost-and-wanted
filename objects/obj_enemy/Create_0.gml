/// @description
x_speed = 0;
y_speed = 0;
ground_angle = 0;
ground_spd = 0;
slope_factor = 0.123;
w_radius = 6;
h_radius = 9;
top_speed = 0.5;
input_h = -1;
subimg = 0;
sensor_angle = 0;
sensor_length_base = 8;
hurting = false;

vec_rt = new Vector2(0,0); //right
vec_lt = new Vector2(0,0); //left
vec_rb = new Vector2(0,0); //right
vec_lb = new Vector2(0,0); //left

vec_b = new Vector2(0,0); //bottom

hurt = function(){
	hurting = true;
	state.change("hurt");
}

no_floor = function(){
	
}

touch_wall = function(){
	ground_spd = 0;
	x_speed = 0;
}

state = new SnowState("idle");

state
.event_set_default_function("draw",function(){
	draw_sprite_ext(sprite_index,subimg,x,y,image_xscale,image_yscale,image_angle,-1,1);
})

.add("idle",{
	enter:function(){	

	},
	step:function(){

	}
})

.add("hurt",{
	enter:function(){
		y_speed = -10;
		x_speed = sign(x-obj_pengu.x) * 6;
		//score_increase(5,5);
		
		point_scatter()
		
		part_particles_create(global.particles,x,y,global.part_stars,12);
	},
	step:function(){
		y_speed += 0.5;
		image_angle-=sign(x_speed) * 6;
		if(global.camera.out_of_bounds(x,y,-30)){
			instance_destroy();	
		}
	}
})