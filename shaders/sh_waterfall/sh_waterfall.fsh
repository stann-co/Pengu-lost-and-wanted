//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_speed;
uniform float u_frequency;
uniform float u_size;

uniform float u_time;

void main()
{
	
	float vertical_wave = cos(u_time * u_speed + v_vTexcoord.x * u_frequency) * u_size;
	
	vec4 distort = v_vColour * texture2D( gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + vertical_wave ));
	
    gl_FragColor = distort;
}
