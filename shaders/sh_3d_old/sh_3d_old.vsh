// Attributes /////////////////////////////////////////////////////////////

attribute vec3 in_Position;
//attribute vec3 in_Normal;
attribute vec2 in_TextureCoord0;
//attribute vec4 in_Colour;


varying vec2 v_vTexcoord;
//varying vec4 v_color;

void main()
{
	vec4 object_space_pos = vec4(in_Position, 1.0);
	
	//v_color = in_Colour;
	v_vTexcoord = in_TextureCoord0;
	
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
}