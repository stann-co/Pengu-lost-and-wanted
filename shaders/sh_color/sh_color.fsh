//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3  u_color;
uniform float u_intensity;

void main()
{	
	vec4 base = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	base.rgb = mix(base.rgb, u_color, u_intensity);
	
	gl_FragColor = base;
}
