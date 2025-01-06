attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec2 in_TextureCoord;
attribute vec4 in_Colour;

uniform mat4 u_Transform; // transform matrix, move rotate scale object

varying vec3 v_normal;
varying vec4 v_color;

void main() {
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * ( u_Transform * vec4( in_Position.x, in_Position.y, in_Position.z, 1.0) );
    v_normal = normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_Normal.x,in_Normal.y,in_Normal.z, 0.0)).xyz);
	v_color = in_Colour;
}