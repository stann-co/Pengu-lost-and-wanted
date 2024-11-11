//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D s_Normal;
uniform sampler2D s_Distortion;


void main()
{
	vec2 normal = texture2D( s_Normal, v_vTexcoord).rg;
	float distortion = texture2D( s_Distortion, v_vTexcoord).r;
	normal = (normal - 0.5) * 2.0 * distortion;

	vec4 col = texture2D( gm_BaseTexture, (v_vTexcoord+normal) );

	gl_FragColor = col;
}
