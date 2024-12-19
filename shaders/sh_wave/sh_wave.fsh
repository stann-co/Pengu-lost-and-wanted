//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_speed;
uniform float u_xFrequency;
uniform float u_xSize;

uniform vec2 u_spriteSize;

uniform float u_time;

void main()
{
	float xFreq = u_xFrequency / u_spriteSize.y;
	float xSize = u_xSize * u_spriteSize.x;
	
	float horizontal_wave = sin(u_time * u_speed   +   v_vTexcoord.y * xFreq) * (xSize * v_vTexcoord.x);
	
	vec4 distort = v_vColour * texture2D( gm_BaseTexture, vec2(v_vTexcoord.x + horizontal_wave , v_vTexcoord.y));
	
	
    gl_FragColor = distort;
}
