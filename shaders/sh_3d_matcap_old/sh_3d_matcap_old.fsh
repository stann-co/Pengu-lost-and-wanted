//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_color;
varying vec3 v_normal;
varying vec3 v_position;
varying vec3 v_viewNormal;

uniform sampler2D s_matcap;

//#pragma shady: import(sh_3d_samples)

void main()
{	
	//vec4 color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	//vec3 N = normalize(v_normal); // Normal vector
    //vec3 L = normalize(vec3(1.,-1.,0.) - v_position); // Light direction
    //vec3 V = vec3(0.,-1.,0.); // View direction
	
	vec4 color = v_color;
	color.rgb *= 0.8;
	
    //vec3 ambient_color = color * .8;
    //vec3 light_color = vec3(1.0, 1.0, 1.0);
	
	// Diffuse lighting
    //float NdotL = max(0.0, dot(N, L));
    //vec3 diffuse_color = NdotL * light_color * color;
	
	// Fresnel effect for reflectivity
	//float fresnel = pow(1.0 - dot(vec3(0.,-1.,0.), v_normal), 5.0) * 0.25;

	//color.rgb += vec3(fresnel);
	
	// Matcap lighting
	vec2 matcap_uv = v_viewNormal.xy * 0.5 + 0.5;   
    vec3 matcap_color = texture2D(s_matcap, matcap_uv).rgb * 0.3;
	
	//float matcap_alpha = dot(matcap_color.rgb, vec3(0.299, 0.587, 0.114));
	//vec4 matcap = vec4(matcap_color,1.);
	//color.rgb += matcap_color;
	
	color.rgb += matcap_color;
	
    gl_FragColor = color;
	
	
	
}
