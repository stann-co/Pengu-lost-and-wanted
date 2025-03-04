/// @function __grid_buffer
/// @description vbuffer for a 3d grid
/// @ignore
function __grid_buffer(_size = 20){
	vertex_format_begin()
	vertex_format_add_position_3d()
	vertex_format_add_color()		
	var format = vertex_format_end()
	
	var grid_ = vertex_create_buffer()
	vertex_begin(grid_,format);
		
	var offset_ = _size /2;

	for (var i = 0; i <= _size; ++i) {
		vertex_position_3d(grid_, -offset_,	i-offset_,	0);  vertex_color(grid_,c_white,1);
		vertex_position_3d(grid_, offset_,	i-offset_,	0);  vertex_color(grid_,c_white,1);    
		
		vertex_position_3d(grid_, i-offset_, -offset_,	0);  vertex_color(grid_,c_white,1);
		vertex_position_3d(grid_, i-offset_, offset_ ,	0);  vertex_color(grid_,c_white,1);    
	}    
	vertex_end(grid_)
	
	return grid_;
}

function draw_grid(_scale = 100){
	static grid = __grid_buffer();
	shader_set(stanncam_sh_gizmo);
	matrix_set(matrix_world,matrix_build(0,0,0,0,0,0,_scale,_scale,_scale))
	vertex_submit(grid,pr_linelist,-1);
	matrix_set(matrix_world,matrix_build_identity())
	shader_reset()
}
	
