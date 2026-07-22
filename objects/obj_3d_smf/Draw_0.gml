
var mat = matrix_build(x, y, -100, rotx, roty, rotz,SCALE_3D, SCALE_3D, SCALE_3D)

draw_set_font(f_debug)

var bone_names = inst.get_bone_names()
//for (var i = 0; i < array_length(bone_names); i++) {
//	var name = bone_names[i];
//    var node = inst.node_get_id(name)
//    
//    var pos = inst.node_get_room_pos(node,mat) 
//    draw_text_outline(pos[0],pos[1],name)
//}


var foot_l = inst.node_get_id("foot.L")-1
var foot_r = inst.node_get_id("foot.R")-1

var root = inst.node_get_id("root")

//var name_ = bone_names[node_]

var fpl = inst.node_get_position(foot_l)
var fpr = inst.node_get_position(foot_r)

inst.node_translate(root,0,-offset/SCALE_3D,0,true)

//pos_ = inst.node_get_room_pos(node_,mat) 
//draw_text_outline(pos_[0],pos_[1],"foot.L")


inst.node_move_ik(foot_l,fpl[0],fpl[1],fpl[2],true,false)
inst.node_move_ik(foot_r,fpr[0],fpr[1],fpr[2],false,false)



//inst.node_drag(node_,x_,y_+offset/SCALE_3D,z_,false)

//Draw 3D instance
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

shader_set(sh_3d_animated)
matrix_set(matrix_world, mat);
inst.draw()
matrix_set(matrix_world, matrix_build_identity());

gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);

shader_reset();

//smf_mat_invert(mat,matInv)