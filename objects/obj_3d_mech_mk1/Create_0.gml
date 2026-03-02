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

rig = new gltfSkinnedMesh("rig-mech");
rig.setAnimation("bindpose");
rig.animate(0)

scale = 32 //1 meter is 32 pixels, maybe make a macro

//animation
hatch_t = 0;
hatch_open = false;
hatch_anim_length = rig.getAnimationLength("hatch");

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
		//rig.setAnimation("standby");
		anim_main = "standby"
		t_max = rig.getAnimationLength("standby");
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
		//rig.setAnimation("walk");
		anim_main = "walk"
		t_max = rig.getAnimationLength("walk");
	},
	step: function(){
		
	}
})

#endregion

//Inspectron()
    //.Section("angle")
    //.SliderInt("rotx",-180,180)
    //.SliderInt("roty",-180,180)
    //.SliderInt("rotz",-180,180)
	//.Slider("test",0,1)
//.render()

