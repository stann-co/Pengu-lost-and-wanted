attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec2 in_TextureCoord0;
attribute vec4 in_Colour;

//attribute vec2 in_TextureCoord1;

//attribute vec4 in_TangentW; // (tangent.xyz, bitangentSign)

varying vec2 v_vTexcoord;
varying vec4 v_color;
varying vec3 v_normal;
varying vec3 v_position;
varying vec3 v_viewNormal;

void main()
{
	
	vec4 object_space_pos = vec4(in_Position, 1.0);
	
	v_color = in_Colour;
	v_position = in_Position;
	v_vTexcoord = in_TextureCoord0;
	
	v_normal = normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0.0)).xyz);
	v_viewNormal = normalize((gm_Matrices[MATRIX_VIEW] * vec4(v_normal, 0.0)).xyz);
	
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	
	
	//ps1 wobble
	//vec4 eye_space = gm_Matrices[MATRIX_WORLD_VIEW] * object_space_pos;
	//eye_space.xyz = floor(eye_space.xyz);
	//gl_Position = gm_Matrices[MATRIX_PROJECTION] * eye_space;
	
	
	//vec3 tangent = in_TangentW.xyz;
	//vec3 bitangent = cross(normal, tangent) * in_TangentW.w;
}