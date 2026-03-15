/// @description

if (controlled){
	if (InputPressed(INPUT_VERB.INTERACT)){
		instance_create_layer(x,y,"Instances",obj_pengu)
		
		global.camera.follow = obj_pengu;
		global.camera.zoom(base_zoom_level,GAME_SPEED*0.5);
		
		state.change("standby_start");
	}	
}

state.step()

#region animation blend
//Hatch
//toggle hatch
if(keyboard_check_pressed(ord("Q"))){
	hatch_open = !hatch_open;
	show_debug_message("hatch toggle!");
}

if(hatch_open){
	if(hatch_t < hatch_anim_length) hatch_t += 1/60;
} else{
	if(hatch_t > 0) hatch_t -= 1/60;
}

t += (1/60);
if(t > t_max) t = 0;



var anim_hatch_ = skinned_mesh.skin.animate(hatch_t, "hatch");

var anim_main_ = skinned_mesh.skin.animate(t,anim_main);

var mask_ = ["DEF-hatch","DEF-ear.L","DEF-ear.R"];
anim_hatch_ = skinned_mesh.maskAnimation(anim_hatch_,mask_,true);

var blended_ = skinned_mesh.blendAnimation(anim_main_,anim_hatch_,test);


skinned_mesh.animateBlended(blended_);


//skinned_mesh.animate(t);

#endregion
