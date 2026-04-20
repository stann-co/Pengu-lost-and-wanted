event_inherited();
/// @description
debug_draw = true;

w_radius = 49;
h_radius = 60;

//control
input_h = 0;
input_v = 0;

acceleration_speed = 0.1;
deceleration_speed = 0.2;
friction_speed = 0.24;
top_speed = 3.073112;
absolute_top_speed = 12;

//mech
mech_zoom_level = 2;
base_zoom_level = 1;

//3D
gltfLoad("3D/mech1.gltf");

skinned_mesh = new gltfSkinnedMesh("rig-mech");

skinned_mesh.setAnimation("bindpose");
skinned_mesh.animate(0)

//animation
hatch_t = 0;
hatch_open = false;
hatch_anim_length = skinned_mesh.getAnimationLength("hatch");

anim_main = undefined;

t = 0;
y_rot_amount = 52;
roty = y_rot_amount;

#region States
 
state = new SnowState("standby")

.add("standby_start",{
	step: function(){
		state.change("standby");
	},
	draw_gui: function(){
		
	}
})

.add("standby",{
	enter: function(){
		anim_main = "standby"
		t_max = skinned_mesh.getAnimationLength("standby");
	},
	step: function(){ 
		if (collision_rectangle(x-w_radius,y-h_radius,x+w_radius,y+h_radius,obj_pengu,false,true) && InputPressed(INPUT_VERB.INTERACT)){
			instance_destroy(obj_pengu);
			set_controlled();
			state.change("standing");
			
			global.camera.follow = self
			global.camera.zoom(mech_zoom_level,GAME_SPEED*0.5);
		}
	},
	draw_gui: function(){
		if (collision_rectangle(x-w_radius,y-h_radius,x+w_radius,y+h_radius,obj_pengu,false,true)){
			var x_ = global.camera.room_to_gui_x(x);
			var y_ = global.camera.room_to_gui_y(y) - 60;
			draw_sprite(spr_gui_button_interact,using_gamepad(),x_,y_);
		}
	}
})

.add("standing",{
	enter: function(){
		anim_main = "walk"
		t_max = skinned_mesh.getAnimationLength("walk");
	},
	step: function(){
		
	}
})

#endregion

rotate = 0;

Inspectron()
    .Section("angle")
	.Slider("rotate",-90,90)
.render()
