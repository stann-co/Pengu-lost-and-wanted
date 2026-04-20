/// @description

if (CONTROLLED){
	if (InputPressed(INPUT_VERB.INTERACT)){
		instance_create_layer(x,y,"Instances",obj_pengu);
		global.camera.follow = obj_pengu;
		global.camera.zoom(base_zoom_level,GAME_SPEED*0.5);
		state.change("standby_start");
	}
	
	input_h = InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT);
	input_v = InputCheck(INPUT_VERB.UP) - InputCheck(INPUT_VERB.DOWN);
	
	if(input_h != 0){
		facing = input_h;
		//if top speed has already been exceeded before this event
		//that becomes the new temporary top speed
		//like for speed ramps and springs and dashing
		var ground_top_speed_ = (abs(ground_spd) > top_speed) ? abs(ground_spd) : top_speed;
		ground_top_speed_ = min(ground_top_speed_,absolute_top_speed);
		
		//if pressing in the opposite direction of ground_spd it decelerates
		if(ground_spd != 0 && sign(ground_spd) != input_h){ //decelerates
			
			//deceleration speed is a bit higher than acceleration speed. but it's only used if ground_speed has already surpassed it
			if(abs(ground_spd) >= deceleration_speed){
				ground_spd += deceleration_speed * input_h;
			} else {
				ground_spd += acceleration_speed * input_h;
			}
			
		} else { //accelerate
			ground_spd += acceleration_speed * input_h;
		}
		
		//clamps to top speed
		ground_spd = clamp(ground_spd,-ground_top_speed_,ground_top_speed_);
	
	} else { //stop | apply friction
		ground_spd -= min(abs(ground_spd), friction_speed) * sign(ground_spd); //decelerate
	}

	//speed depends on the angle of the floor
	ground_spd-=slope_factor * dsin(ground_angle);	
	
	// Calculate x and y_speed from ground_speed
	x_speed = ground_spd * dcos(ground_angle)
	y_speed = ground_spd * -dsin(ground_angle)
	
	
	x+=x_speed;
	y+=y_speed;
	
}

state.step()

roty = lerp(roty,-y_rot_amount*facing,0.05);

#region animation blend

t += (1/60);
if(t > t_max) t = 0;

var walking_  = skinned_mesh.skin.animate(t,"walk");
var standing_ = skinned_mesh.skin.animate(t,"stand");

var pose_ = skinned_mesh.blendAnimation(standing_,walking_,abs(ground_spd)/top_speed);

//var mask_ = ["DEF-hatch","DEF-ear.L","DEF-ear.R"];
//anim_hatch_ = skinned_mesh.maskAnimation(anim_hatch_,mask_,true);
//var blended_ = skinned_mesh.blendAnimation(walking_,anim_hatch_,test);

//var bone_ = skinned_mesh.getBoneIndex("DEF-foot.R");


skinned_mesh.animateBlended(pose_);

#endregion

#region legs IK

//var foot_pos = skinned_mesh.getBoneWorldPosition(bone_);
//
//skinned_mesh.setBoneIk(pose_,"DEF-thigh.R","DEF-leg.R","DEF-foot.R",foot_pos);
//
//skinned_mesh.animateBlended(pose_);

#endregion

var root_ = skinned_mesh.getBoneIndex("root");

var chest_ = skinned_mesh.getBoneIndex("DEF-chest");

var thigh_ = skinned_mesh.getBoneIndex("DEF-thigh.R");
var leg_ = skinned_mesh.getBoneIndex("DEF-leg.R");
var foot_ = skinned_mesh.getBoneIndex("DEF-foot.R");

//pose_ = skinned_mesh.offsetBoneEuler(pose_,thigh_,-rotate);
//pose_ = skinned_mesh.offsetBoneEuler(pose_,leg_,rotate);

//rotate foot to match slope
//pose_ = skinned_mesh.offsetBoneWorldEuler(pose_,foot_,0,0,rotate);

//pose_ = skinned_mesh.offsetBoneEuler(pose_,root_,rotate);

skinned_mesh.animateBlended(pose_);




