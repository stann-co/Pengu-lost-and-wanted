event_inherited()

debug_draw = true;

w_radius = 49;
h_radius = 64;

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

y_rot_amount = 52;
rotx = 0;
roty = y_rot_amount;
rotz = 0;

offset = 0;

//3D
model = smf_model_load("3D/pengu_mech.smf");
inst = new smf_instance(model);
inst.play("standby",.02,1,true);


/* Inspectron()
    .Section("angle")
    .SliderInt("rotx",-360,360)
    .SliderInt("roty",-360,360)
    .SliderInt("rotz",-360,360)

    .SliderInt("offset",-32,32)

    .SliderInt("index_offset",-3,3)
.render() */

//matInv = array_create(16)

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
        inst.play("standby",.02,0.1,true);
    },
    step: function(){
		if (collision_rectangle(x-w_radius,y-h_radius,x+w_radius,y+h_radius,obj_pengu,false,true) && InputPressed(INPUT_VERB.INTERACT)){
			instance_destroy(obj_pengu);
			set_controlled();
			state.change("standing");
			
			global.camera.follow = self
			global.camera.zoom(mech_zoom_level,SECOND*0.5);
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
        inst.play("stand",.02,0.1,true);
    }
})



#endregion