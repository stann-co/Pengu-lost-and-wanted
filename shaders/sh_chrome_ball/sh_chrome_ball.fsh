//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float zoom1;
uniform float zoom2;
uniform float zoom3;

float saturaton = 0.0;

void main()
{
	float dist = length(v_vTexcoord - 0.5);
	float offset = dist *  ((zoom2 * dist / zoom3) + zoom1);
	vec2 sample = normalize(v_vTexcoord - 0.5) * offset + 0.5;
	
	vec4 base_col = texture2D( gm_BaseTexture, sample);
	
	//base_col.rgb = mix(vec3(dot(base_col.rgb, vec3(0.299, 0.587, 0.114))), base_col.rgb, saturaton);
	
	base_col.a = mix(base_col.a,0.0,step(0.5,dist));
	
	
    gl_FragColor = base_col;
}
