//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 color;
uniform float intensity;

void main()
{	
	vec4 base = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	vec3 base_col = base.rgb;
	
	vec3 new_col = mix(base_col, color, intensity);
	
	gl_FragColor = vec4(new_col.r,new_col.g,new_col.b,base.a);
}
