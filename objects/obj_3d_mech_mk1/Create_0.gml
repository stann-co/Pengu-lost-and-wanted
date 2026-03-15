/// @description

/// @description
controlled = false;
debug_draw = true;

airborne = false;
on_land = false;

input_h = 0;
input_v = 0;
x_speed = 0;
y_speed = 0;

ground_spd = 0; //how fast it's moving on the ground
ground_angle = 0; //the grounds angle

w_radius = 49;
h_radius = 60;

mech_zoom_level = 2;
base_zoom_level = 1;


//3D
var loaded_ = gltfLoad("3D/mech1.gltf")

skinned_mesh = new gltfSkinnedMesh("rig-mech");
skinned_mesh.setAnimation("bindpose");
skinned_mesh.animate(0)

//animation
hatch_t = 0;
hatch_open = false;
hatch_anim_length = skinned_mesh.getAnimationLength("hatch");

anim_main = undefined;

t = 0;

rotx = 0;
roty = 52;
rotz = 0;
test = 0;

 #region States
 
state = new SnowState("standby")

.add("standby_start",{
	enter: function(){
		controlled = false;
	},
	step: function(){ 
		state.change("standby");
	},
	draw_gui: function(){
		
	}
})

.add("standby",{
	enter: function(){
		controlled = false;
		//skinned_mesh.setAnimation("standby");
		anim_main = "standby"
		t_max = skinned_mesh.getAnimationLength("standby");
	},
	step: function(){ 
		if (collision_rectangle(x-w_radius,y-h_radius,x+w_radius,y+h_radius,obj_pengu,false,true) && InputPressed(INPUT_VERB.INTERACT)){
			instance_destroy(obj_pengu);
			controlled = true;
			state.change("walking");
			
			global.camera.follow = self
			global.camera.zoom(mech_zoom_level,GAME_SPEED*0.5);
		}
	},
	draw_gui: function(){
		if (collision_rectangle(x-w_radius,y-h_radius,x+w_radius,y+h_radius,obj_pengu,false,true)){
			var x_ = global.camera.room_to_gui_x(x)
			var y_ = global.camera.room_to_gui_y(y) - 60
			draw_sprite(spr_gui_button_interact,using_gamepad(),x_,y_);
		}
	}
})

.add("walking",{
	enter: function(){
		//skinned_mesh.setAnimation("walk");
		anim_main = "walk"
		t_max = skinned_mesh.getAnimationLength("walk");
	},
	step: function(){
		
	}
})

#endregion

Inspectron()
    .Section("angle")
    .SliderInt("rotx",-180,180)
    .SliderInt("roty",-180,180)
    .SliderInt("rotz",-180,180)
	.Slider("test",0,1)
.render()

