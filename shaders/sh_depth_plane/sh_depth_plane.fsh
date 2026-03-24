//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_t;

const float shortening = 0.01;
const float speed = 0.02;
const float rows = 12.0;

void main()
{
	vec2 coord = v_vTexcoord;
	float narrowness = mix(1.0,shortening,1.0 - v_vTexcoord.y);
	coord.x = ((coord.x - 0.5) / narrowness) / rows;
	coord.x += (u_t*speed)/rows;
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, coord );
}
