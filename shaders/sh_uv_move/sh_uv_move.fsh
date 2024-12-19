//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_spriteSize;

uniform vec2 u_speed;
uniform float u_time;

void main()
{	
	vec2 speed = u_speed * u_spriteSize;
	vec2 uv_move = vec2(v_vTexcoord.x + u_time*speed.x, v_vTexcoord.y + u_time*speed.y);	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, uv_move);
}
