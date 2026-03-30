//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_t;

const float shortening = 0.01;
const float speed = 0.03;
const float rows = 1.0;

void main()
{
	vec2 coord = v_vTexcoord;
	float narrowness = mix(1.0,shortening,1.0-v_vTexcoord.y);
	coord.x = ((coord.x - 0.5) / narrowness) * rows;
	coord.x += (u_t*speed)*rows;
	coord.y = (1.0-coord.y) / narrowness;//mix(narrowness,0.0,0.5);
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, coord );
	//gl_FragColor = vec4(v_vTexcoord.x,v_vTexcoord.y,0.0,1.0);
}
