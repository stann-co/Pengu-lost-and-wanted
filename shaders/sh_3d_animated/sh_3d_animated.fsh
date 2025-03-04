//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_color;
varying vec3 v_normal;
varying vec3 v_position;
varying vec3 v_viewNormal;

uniform sampler2D s_matcap;

void main()
{
    vec4 color = v_color;
	color.rgb *= 0.8;
	vec2 matcap_uv = v_viewNormal.xy * 0.5 + 0.5;   
    vec3 matcap_color = texture2D(s_matcap, matcap_uv).rgb * 0.3;
	
	color.rgb += matcap_color;
	
    gl_FragColor = color;
	
}
