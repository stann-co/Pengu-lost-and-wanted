function gltf(filepath) constructor{

	var buffer = buffer_load(filepath);
	var meta = json_parse(buffer_read(buffer,buffer_text));	
	buffer_delete(buffer);
	buffer = buffer_load(string_replace(filepath,".gltf",".bin"));
	
	#region mesh
	var mesh = meta.meshes[0].primitives[0];
	var position_offset = meta.bufferViews[mesh.attributes.POSITION].byteOffset;
	var position_count  = meta.accessors[mesh.attributes.POSITION].count;
	var normal_offset = meta.bufferViews[mesh.attributes.NORMAL].byteOffset;
	var normal_count = meta.accessors[mesh.attributes.NORMAL].count;
	var color_offset = meta.bufferViews[mesh.attributes.COLOR_0].byteOffset;
	var color_count = meta.accessors[mesh.attributes.COLOR_0].count;
	var index_offset = meta.bufferViews[mesh.indices].byteOffset;
	var index_count = meta.accessors[mesh.indices].count;
	
	var pos		= buffer_create(0, buffer_grow, 4); //vec3
	var normal  = buffer_create(0, buffer_grow, 4); //vec3
	var color	= buffer_create(0, buffer_grow, 2); //vec4
	buffer_seek(pos, buffer_seek_start, 0);
	buffer_seek(normal, buffer_seek_start, 0);
	buffer_seek(color, buffer_seek_start, 0);

	//position
	buffer_seek(buffer,buffer_seek_start,position_offset);
	repeat(position_count){
		buffer_write(pos,buffer_f32, buffer_read(buffer,buffer_f32) );
		buffer_write(pos,buffer_f32, buffer_read(buffer,buffer_f32) );
		buffer_write(pos,buffer_f32, buffer_read(buffer,buffer_f32) );
	}
	
	//normal
	buffer_seek(buffer,buffer_seek_start,normal_offset);
	repeat(normal_count){
		buffer_write(normal,buffer_f32, buffer_read(buffer,buffer_f32) );
		buffer_write(normal,buffer_f32, buffer_read(buffer,buffer_f32) );
		buffer_write(normal,buffer_f32, buffer_read(buffer,buffer_f32) );
	}
	
	//color
	buffer_seek(buffer,buffer_seek_start,color_offset);
	repeat(color_count){
		buffer_write(color,buffer_u16, buffer_read(buffer,buffer_u16) );
		buffer_write(color,buffer_u16, buffer_read(buffer,buffer_u16) );
		buffer_write(color,buffer_u16, buffer_read(buffer,buffer_u16) );
		buffer_write(color,buffer_u16, buffer_read(buffer,buffer_u16) );
	}
	
	//indice array
	var indice_array = [];
	buffer_seek(buffer,buffer_seek_start,index_offset);
	repeat(index_count){
		array_push(indice_array, buffer_read(buffer,buffer_u16));
	}
	
	//creates triangles
	static vf = __make_vertex_format();
	vbuff = vertex_create_buffer();
	vertex_begin(vbuff,vf);

	for (var i = 0; i < array_length(indice_array); ++i) {
		var index = indice_array[i];
		buffer_seek(pos,buffer_seek_start,index*4*3); //index * 4 byte * vector3
		var pos_x = buffer_read(pos,buffer_f32);
		var pos_y = buffer_read(pos,buffer_f32);
		var pos_z = buffer_read(pos,buffer_f32);
		
		buffer_seek(normal,buffer_seek_start,index*4*3); //index * 4 byte * vector3
		var nor_x = buffer_read(normal,buffer_f32);
		var nor_y = buffer_read(normal,buffer_f32);
		var nor_z = buffer_read(normal,buffer_f32);
		
		buffer_seek(color,buffer_seek_start,index*2*4); //index * 2 byte * vector4
		var col_r = buffer_read(color,buffer_u16) / 65535;
		var col_g = buffer_read(color,buffer_u16) / 65535;
		var col_b = buffer_read(color,buffer_u16) / 65535;
		var col_a = buffer_read(color,buffer_u16) / 65535;
		
		vertex_position_3d(vbuff, pos_x, pos_y, pos_z);
		vertex_normal(vbuff, nor_x, nor_y, nor_z);
		var vcol = make_color_rgb(col_r*255,col_g*255,col_b*255);
		vertex_color(vbuff,vcol,col_a);
	}
	
	buffer_delete(pos);
	buffer_delete(normal);
	buffer_delete(color);
	
	vertex_end(vbuff);
	vertex_freeze(vbuff);
	#endregion
	
	#region animations
	
	animations = [];
	for (var i = 0; i < array_length(meta.animations); ++i) {
		
		var _min = meta.accessors[meta.animations[i].samplers[0].input].min[0];
		var _max = meta.accessors[meta.animations[i].samplers[0].input].max[0];
		var duration = _max - _min //anim duration in seconds
		if(duration == 0) continue;
		
		var pos_offset		= meta.bufferViews[ meta.animations[i].samplers[0].output].byteOffset;
		var pos_count		= meta.accessors[	meta.animations[i].samplers[0].output].count;
		var rotate_offset	= meta.bufferViews[	meta.animations[i].samplers[1].output].byteOffset;
		var rotate_count	= meta.accessors[	meta.animations[i].samplers[1].output].count;
		var scale_offset	= meta.bufferViews[	meta.animations[i].samplers[2].output].byteOffset;
		var scale_count		= meta.accessors[	meta.animations[i].samplers[2].output].count;
		
		pos = [];
		var rot = [];
		var scale = [];
		
		//position
		buffer_seek(buffer,buffer_seek_start,pos_offset);
		repeat(pos_count){
			var x_ = buffer_read(buffer,buffer_f32);
			var y_ = buffer_read(buffer,buffer_f32);
			var z_ = buffer_read(buffer,buffer_f32);
			array_push(pos,new vec3(x_,y_,z_));
		}
		
		//rotation
		buffer_seek(buffer,buffer_seek_start,rotate_offset);
		repeat(rotate_count){
			var x_ = buffer_read(buffer,buffer_f32);
			var y_ = buffer_read(buffer,buffer_f32);
			var z_ = buffer_read(buffer,buffer_f32);
			var w_ = buffer_read(buffer,buffer_f32);
			array_push(rot,quaternion_to_euler(x_,y_,z_,w_));
		}
		
		//scale
		buffer_seek(buffer,buffer_seek_start,scale_offset);
		repeat(scale_count){
			var x_ = buffer_read(buffer,buffer_f32);
			var y_ = buffer_read(buffer,buffer_f32);
			var z_ = buffer_read(buffer,buffer_f32);
			array_push(scale,new vec3(x_,y_,z_));
		}
		array_push(animations, new gltf_animation( meta.animations[i].name, pos, rot, scale, duration ));
	}
	
	
	#endregion
	

}

function gltf_animation(_name,_pos,_rot,_scale,_duration) constructor {
	name = _name;
	positions = _pos;
	rotations = _rot;
	scales = _scale;
	duration = _duration;

	//returns keyframe data at this second
	static get = function(_sec){
		var t = duration  / _sec;
		
		var pos_t = (array_length(positions)-1) / t;
		var pos1 = positions[floor(pos_t)]; //linearly blends between 2 keyframes
		var pos2 = positions[ceil(pos_t)];
		var pos = pos1.blend(pos2,frac(pos_t));
		
		var rot_t = (array_length(rotations)-1) / t;
		var rot1 = rotations[floor(rot_t)];
		var rot2 = rotations[ceil(rot_t)];
		var rot = rot1.blend(rot2,frac(rot_t));
		
		var scale_t = (array_length(scales)-1) / t;
		var scale1 = scales[floor(scale_t)];
		var scale2 = scales[ceil(scale_t)];
		var scale = scale1.blend(scale2,frac(scale_t))
		
		return matrix_build(pos.x,pos.y,pos.z,rot.x,rot.y,rot.z,scale.x,scale.y,scale.z);

	}
}

function vec3(_x,_y,_z) constructor{
	x = _x;
	y = _y;
	z = _z;
	
	static blend = function(_vec3,_amount) {
		return new vec3(
			lerp(x,_vec3.x,_amount),
			lerp(y,_vec3.y,_amount),
			lerp(z,_vec3.z,_amount)
		)
	}
}

function __make_vertex_format(){
		vertex_format_begin()
		vertex_format_add_position_3d()
		vertex_format_add_normal()
		vertex_format_add_color()
		return vertex_format_end()
}

function quaternion_to_euler(qx, qy, qz, qw) {
    var _x, _y, _z;

    // Roll (x-axis rotation)
    var sinr_cosp = 2 * (qw * qx + qy * qz);
    var cosr_cosp = 1 - 2 * (qx * qx + qy * qy);
    _x = arctan2(sinr_cosp, cosr_cosp);

    // Pitch (y-axis rotation)
    var sinp = 2 * (qw * qy - qz * qx);
    if (abs(sinp) >= 1) {
        _y = sign(sinp) * 90; // Clamp to 90 degrees if out of range
    } else {
        _y = arcsin(sinp);
    }

    // Yaw (z-axis rotation)
    var siny_cosp = 2 * (qw * qz + qx * qy);
    var cosy_cosp = 1 - 2 * (qy * qy + qz * qz);
    _z = arctan2(siny_cosp, cosy_cosp);

    // Return angles in degrees (GameMaker uses degrees for Euler)
	return new vec3(_x * 180 / pi, _y * 180 / pi, _z * 180 / pi)
}