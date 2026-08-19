//vertex_format_add_position_3d();
//vertex_format_add_normal();
//vertex_format_add_texcoord();
//vertex_format_add_custom(vertex_type_ubyte4, vertex_usage_texcoord); // INDICES
//vertex_format_add_custom(vertex_type_float4, vertex_usage_texcoord); // WEIGHTS
//vertex_format_add_color();

attribute vec3 in_Position;                  // (x,y,z)
attribute vec3 in_Normal;                  // (x,y,z)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec4 in_Indices;
attribute vec4 in_Weights;
attribute vec4 in_Colour;                    // (r,g,b,a)

varying vec2 vTexcoord;
varying vec4 vColour;
varying vec3 vNormal;
varying vec3 vViewNormal;

uniform mat4 uBones[24];

void main()
{
	mat4 skinMatrix =
		in_Weights.x * uBones[int(in_Indices.x)] +
		in_Weights.y * uBones[int(in_Indices.y)] +
		in_Weights.z * uBones[int(in_Indices.z)] +
		in_Weights.w * uBones[int(in_Indices.w)];
		
	vec4 pos = vec4(in_Position, 1.);
	pos = skinMatrix * pos;
	
	pos = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * pos;
	
	gl_Position = pos;
	
    vColour = in_Colour;
    vTexcoord = in_TextureCoord;
	
	vec3 skinnedNormal = normalize((skinMatrix * vec4(in_Normal,0.0)).xyz);
	
	vNormal = normalize((gm_Matrices[MATRIX_WORLD] * vec4(skinnedNormal, 0.0)).xyz);
	vViewNormal = normalize((gm_Matrices[MATRIX_VIEW] * vec4(vNormal, 0.0)).xyz);
}