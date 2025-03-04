attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec2 in_TextureCoord;
attribute vec4 in_Colour;

uniform mat4 u_Transform; // transform matrix, move rotate scale object

varying vec3 v_normal;
varying vec3 v_position;
varying vec4 v_color;

varying vec3 v_viewNormal;

void main() {
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4( in_Position, 1.0);
    v_normal = normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0.0)).xyz);
	v_color = in_Colour;
	v_position = in_Position;	
	v_viewNormal = normalize((gm_Matrices[MATRIX_VIEW] * vec4(v_normal, 0.0)).xyz);
}