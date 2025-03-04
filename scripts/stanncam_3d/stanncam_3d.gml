// Feather disable all

/// @constructor stanncam_3d
/// @description creates a new 3d stanncam
/// @param {Real} [_width=global.game_w]
/// @param {Real} [_height=global.game_h]
/// @param {Bool} [_surface_extra_on=false] - use surface_extra in regular draw events
function stanncam_3d(_width=global.game_w, _height=global.game_h, _surface_extra_on=false, _smooth_draw=true) : __stanncam_base(_width, _height, _surface_extra_on) constructor{
	
	camera_set_begin_script(view_camera[cam_id],function(){
		stanncam_3d_draw(true);
	});
	
	debug_draw = true;
	
	fov = 45;
	
	spd = 4;
	
	cam_up = new stanncam_vec3(0,0,-1)
	
	position_mat = matrix_build(0,0,0,0,0,0,1,1,1);
	scale_mat = matrix_build(0,0,0,0,0,0,1,1,1);
	rotation_mat = matrix_build(0,0,0,90,0,0,1,1,1);
	offset_mat = matrix_build(0,0,0,0,0,0,1,1,1);
	
	x = 0;
	y = 0;
	z = 0;
	offset_x = x;
	offset_y = y;
	offset_z = z;

	/// @function __step
	/// @description gets called every step
	/// @ignore
	static __step = function(){
		//camera location is inverse from worldspace apparently
		var pos =  matrix_inverse(matrix_multiply(position_mat,offset_mat))
		var viewmat = matrix_multiply(pos,matrix_multiply(rotation_mat,scale_mat));
		var projmat = matrix_build_projection_perspective_fov(fov,width/height,1,32000);
		
		camera_set_view_mat(__camera, viewmat);
		camera_set_proj_mat(__camera, projmat);
		camera_apply(__camera);
	}
	
	/// @function pos_to_screen
	/// @description returns 3d position into screen position relative to camera
	/// @returns x,y struct
	/// @ignore
	static pos_to_screen = function(_v){
		var proj_mat = camera_get_proj_mat(__camera);
		var view_mat = camera_get_view_mat(__camera)
		
		if (proj_mat[15] == 0) {   //This is a perspective projection
		    var w = view_mat[2] * _v.x + view_mat[6] * _v.y + view_mat[10] * _v.z + view_mat[14];
		    // If you try to convert the camera's "from" position to screen space, you will
		    // end up dividing by zero (please don't do that)
		    //if (w <= 0) return [-1, -1];
		    if (w == 0) return [-1, -1];
		    var cx = proj_mat[8] + proj_mat[0] * (view_mat[0] * _v.x + view_mat[4] * _v.y + view_mat[8] * _v.z + view_mat[12]) / w;
		    var cy = proj_mat[9] + proj_mat[5] * (view_mat[1] * _v.x + view_mat[5] * _v.y + view_mat[9] * _v.z + view_mat[13]) / w;
		} else {    //This is an ortho projection
		    var cx = proj_mat[12] + proj_mat[0] * (view_mat[0] * _v.x + view_mat[4] * _v.y + view_mat[8]  * _v.z + view_mat[12]);
		    var cy = proj_mat[13] + proj_mat[5] * (view_mat[1] * _v.x + view_mat[5] * _v.y + view_mat[9]  * _v.z + view_mat[13]);
		}
		
		return {
			x: (0.5 + 0.5 * cx) * width,
			y: (0.5 + 0.5 * -cy) * height
		};
	}
	
	#region dynamic functions
		/// @function set_position
		/// @description sets camera position
		/// @ignore
		static set_position = function(_x,_y,_z){
			x = _x;
			y = _y;
			z = _z;
			position_mat = matrix_build(_x,_y,_z,0,0,0,1,1,1);
		}
		
		/// @function get_position
		/// @description gets camera position
		/// @ignore
		static get_position = function(){
			return new stanncam_vec3(x,y,z);
		}
		
		/// @function set_offset
		/// @description offset from position
		/// @ignore
		static set_offset = function(_x,_y,_z){
			offset_x = _x;
			offset_y = _y;
			offset_z = _z;
			offset_mat = matrix_build(_x,_y,_z,0,0,0,1,1,1);
		}
		
		/// @function set_rotation
		/// @description sets camera rotation
		/// @ignore
		static set_rotation = function(_x,_y,_z){
			rotation = matrix_build(0,0,0,_x,_y,_z,1,1,1);
		}
		
		/// @function get_pitch
		/// @description get camera pitch
		/// @ignore
		static get_pitch = function(){
			var right = get_right();
			var forward = get_forward();			
			var test = cam_up.dot(forward)
			return cam_up.dot(forward) * 90;
		}
		
		/// @function get_yaw
		/// @description get camera yaw
		/// @ignore
		static get_yaw = function(){
			var mat = rotation_mat
			if(abs(mat[9] < 1)){
				return radtodeg( arctan2(mat[8],mat[10]) );	
			} else { //gimbal lock
				return radtodeg( arctan2(-mat[4],mat[0]) );
			}
		}
		
		/// @function get_roll
		/// @description get camera roll
		/// @ignore
		static get_roll = function(){
			var mat = rotation_mat
			if(abs(mat[9] < 1)){
				return radtodeg( arctan2(mat[1],mat[5]) );	
			} else { //gimbal lock
				return 0;
			}
		}
			
		/// @function get_right 
		/// @description gets right vector
		/// @ignore
		static get_right = function(){
			var mat = rotation_mat;
			var x_ = stanncam_decimal(mat[0]);
			var y_ = stanncam_decimal(mat[4]);
			var z_ = stanncam_decimal(mat[8]);
			var right = new stanncam_vec3(x_,y_,z_)
			return right.normalize();
		}
		
		/// @function get_forward
		/// @description gets forward vector
		/// @ignore
		static get_forward = function(){
			var mat = rotation_mat;
			var x_ = stanncam_decimal(mat[2]);
			var y_ = stanncam_decimal(mat[6]);
			var z_ = stanncam_decimal(mat[10]);
			var forward = new stanncam_vec3(x_,y_,z_)
			return forward.normalize();
		}
		
		/// @function get_up
		/// @description gets up vector
		/// @ignore
		static get_up = function(){
			var mat = rotation_mat;
			var x_ = stanncam_decimal(mat[1]);
			var y_ = stanncam_decimal(mat[5]);
			var z_ = stanncam_decimal(mat[9]);
			var up = new stanncam_vec3(x_,y_,z_)
			return up.normalize();
		}
		
		/// @function translate
		/// @description translate camera
		/// @ignore
		static translate = function(_x,_y,_z){
			var translation = matrix_build(_x,_y,_z,0,0,0,1,1,1);
			position_mat = matrix_multiply(position_mat,translation)
			x+=_x;
			y+=_y;
			z+=_z;
		}
		
		/// @function translate_relative
        /// @description translate camera relative to its rotation
        /// @ignore
        static translate_relative = function(_x, _y, _z) {
			var right = get_right();
			var forward = get_forward();
			var up = get_up();
			
			var tx = (right.x*_x + forward.x*_y + up.x*_z)*spd;
			var ty = (right.y*_x + forward.y*_y + up.y*_z)*spd;
			var tz = (right.z*_x + forward.z*_y + up.z*_z)*spd;
			
			x+=tx;
			y+=ty;
			z+=tz;
			
			var translation = [
				1,	0,	0,	0,
				0,	1,	0,	0,
				0,	0,	1,	0,
				tx,	ty,	tz,	1
			]
			position_mat = matrix_multiply(position_mat,translation)
        }
		
		/// @function rotate
		/// @description rotate camera
		/// @ignore
		static rotate = function(_pitch,_yaw){			

			var target = get_forward()
			var right = get_right();
			
			var pitch = get_pitch()
			var pitch_move = clamp(pitch + _pitch,-90,90) - pitch;
			
			target = target.rotate_by_axis(cam_up,_yaw);
			target = target.rotate_by_axis(right,pitch_move);
			
			// Calculate the new camera position by rotating around _vec3
			var cam_pos = new stanncam_vec3(offset_x,offset_y,offset_z);

		    cam_pos = cam_pos.rotate_by_axis(cam_up, _yaw);
		    cam_pos = cam_pos.rotate_by_axis(right, pitch_move);
			
			set_offset(cam_pos.x,cam_pos.y,cam_pos.z)
			
			rotation_mat = matrix_build_lookat(0,0,0,target.x,target.y,target.z,-cam_up.x,-cam_up.y,-cam_up.z);
		}
		
		/// @function set_target
		/// @description set target
		/// @ignore
		static set_target = function(_x,_y,_z){
			var target_x = _x - x - offset_x;
			var target_y = _y - y - offset_y;
			var target_z = _z - z - offset_z;
			rotation_mat = matrix_build_lookat(0,0,0,target_x,target_y,target_z,-cam_up.x,-cam_up.y,-cam_up.z);
		}
		
	#endregion
	
	#region draw functions
	
	/// @function draw_gizmo
	/// @description draws debug information
	/// @ignore
	static draw_gizmo = function(_x = 0, _y = 0, _scale_x = 1, _scale_y = 1){
		var gizmo_surf_ = surface_create(40,40)
		surface_set_target(gizmo_surf_);
			draw_clear_alpha(c_white,0)
			
			static gizmo = __gizmo_buffer();
				
			var world_matrix = matrix_get(matrix_world)
			matrix_set(matrix_world, matrix_multiply(rotation_mat,matrix_build(20,20,0,0,0,0,20,20,20)));
			shader_set(stanncam_sh_gizmo);
			vertex_submit(gizmo,pr_linelist,-1);
			shader_reset()
			matrix_set(matrix_world,world_matrix);
		surface_reset_target()			
		draw_surface(gizmo_surf_,_x,_y);
		surface_free(gizmo_surf_);			
	}
	
	/// @function __gizmo_format
	/// @description vformat for a 3d gizmo
	/// @ignore
	static __gizmo_format = function(){
		vertex_format_begin()
		vertex_format_add_position_3d()
		vertex_format_add_color()		
		return vertex_format_end()
	}
	
	/// @function __gizmo_buffer
	/// @description vbuffer for a 3d gizmo
	/// @ignore
	static __gizmo_buffer = function(){
		static gizmo_format = __gizmo_format();
			
		var gizmo_ = vertex_create_buffer()
		vertex_begin(gizmo_,gizmo_format);
		vertex_position_3d(gizmo_,0,0,0);  vertex_color(gizmo_,c_red,1);
		vertex_position_3d(gizmo_,1,0,0);  vertex_color(gizmo_,c_red,1); //X
		vertex_position_3d(gizmo_,0,0,0);  vertex_color(gizmo_,c_green,1);
		vertex_position_3d(gizmo_,0,1,0);  vertex_color(gizmo_,c_green,1); //Y
		vertex_position_3d(gizmo_,0,0,0);  vertex_color(gizmo_,c_blue,1);
		vertex_position_3d(gizmo_,0,0,1);  vertex_color(gizmo_,c_blue,1); //Z
		vertex_end(gizmo_)
		return gizmo_;
	}
	#endregion
}

