/// @description

player = {
	pos: new stanncam_vec3(0,40,-1),
	rot: new stanncam_vec3(1,0,0),
	target: new stanncam_vec3(1,0,0),
	size: new stanncam_vec3(1,1,1),
	shape : cm_box(matrix_build_identity()),
	
	update_shape : function(){
		var pos_mat = matrix_build(pos.x,pos.y,pos.z,0,0,0,size.x,size.y,size.z)
		rot = rot.rotate_to(target,0.1);
		var rot_mat = stanncam_3d_rotation_matrix(rot)
		shape[@ CM_BOX.M] = matrix_multiply(rot_mat,pos_mat);
	},
	
	move : function(_x,_y,_z){
		var move_amount = new stanncam_vec3(_x,_y,_z);
		pos = pos.add(move_amount);
	}
}
player.update_shape()

global.camera_3d.set_position(player.pos.x,player.pos.y,player.pos.z);
global.camera_3d.set_offset(5,0,-5)
global.camera_3d.set_target(player.pos.x,player.pos.y,player.pos.z);

test = new BBMOD_Model("3D/rig_test.bbmod").freeze();
anim = new BBMOD_Animation("3D/rig_test_move.bbanim");

test.Materials[@ 0] = new material_animated();

animplayer = new BBMOD_AnimationPlayer(test);
animplayer.change(anim, true);

rot_x = 0;
rot_y = 0;

mx = 0;
my = 0;

var regionsize = 10;
global.colmesh = cm_spatialhash(regionsize);
ground = cm_aab(0,0,-5,100,100,10);

//list = cm_list()
//dynamic = cm_dynamic(list)
//cm_spatialhash_add(global.colmesh,box1);
//cm_spatialhash_add(global.colmesh,box2);
//cm_spatialhash_add(global.colmesh,box3);