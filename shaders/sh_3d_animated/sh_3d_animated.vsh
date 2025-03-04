// Attributes /////////////////////////////////////////////////////////////

attribute vec4 in_Position;
attribute vec3 in_Normal;
attribute vec2 in_TextureCoord0;
attribute vec4 in_Colour;
attribute vec4 in_TangentW; // (tangent.xyz, bitangentSign)



// uniforms ///////////////////////////////////////////////////////////////////
// Maximum number of bones of animated models
#define BBMOD_MAX_BONES 128
uniform vec4 bbmod_Bones[2 * BBMOD_MAX_BONES];

// Varyings ///////////////////////////////////////////////////////////////

varying vec2 v_vTexcoord;
varying vec4 v_color;
varying vec3 v_normal;
varying vec3 v_position;
varying vec3 v_viewNormal;

// Includes ///////////////////////////////////////////////////////////////

#pragma shady: import(sh_3d_bones)

//////////////////////////////////////////////////////////////////////////////////
//
// Main
//

void main()
{	
	vec4 position = in_Position;
	vec3 normal = in_Normal;
	vec3 tangent = in_TangentW.xyz;
	vec3 bitangent = cross(normal, tangent) * in_TangentW.w;

	Transform(position, normal, tangent, bitangent);
	
	gl_Position = gm_Matrices[MATRIX_PROJECTION] * (gm_Matrices[MATRIX_VIEW] * position);
	v_position = position.xyz;
	v_vTexcoord = in_TextureCoord0;
	v_color = in_Colour;
	v_normal = normal;
	v_viewNormal = normalize((gm_Matrices[MATRIX_VIEW] * vec4(v_normal, 0.0)).xyz);
	
}