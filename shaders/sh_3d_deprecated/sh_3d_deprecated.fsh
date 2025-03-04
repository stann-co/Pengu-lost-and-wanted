varying vec3 v_normal;
varying vec3 v_position;
varying vec4 v_color; // Base color with alpha
varying vec3 v_viewNormal;

uniform vec3 light_position; // Position of a point light source
uniform vec3 camera_position; // Camera/view position
uniform float refractive_index; // Refraction strength

uniform sampler2D matcap; // Matcap texture

void main() {
	vec3 color = v_color.rgb * 1.;
	
    vec3 ambient_color = color * .8;
    vec3 light_color = vec3(1.0, 1.0, 1.0);

    // Normalized vectors
    vec3 N = normalize(v_normal); // Normal vector
    vec3 L = normalize(light_position - v_position); // Light direction
    vec3 V = normalize(camera_position - v_position); // View direction
    vec3 R = reflect(-L, N); // Reflected light direction

    // Fresnel effect for reflectivity
    float fresnel = pow(1.0 - dot(V, N), 3.0) * 0.5 + 0.1;

    // Diffuse lighting
    float NdotL = max(0.0, dot(N, L));
    vec3 diffuse_color = NdotL * light_color;

    // Specular highlights (Blinn-Phong)
    vec3 H = normalize(L + V); // Halfway vector
    float NdotH = max(0.0, dot(N, H));
    float specular_strength = 1.;
    vec3 specular_color = pow(NdotH, 16.0) * light_color * specular_strength;

	// Matcap lighting
	vec2 matcap_uv = v_viewNormal.xy * 0.5 + 0.5;   
    vec3 matcap_color = texture2D(matcap, matcap_uv).rgb * 0.5;
	
	float matcap_alpha = dot(matcap_color.rgb, vec3(0.299, 0.587, 0.114));
	vec4 matcap = vec4(matcap_color,matcap_alpha);
	
	// Combine lighting components
    vec3 final_color = ambient_color
                       + diffuse_color * color
					   + matcap_color;

    gl_FragColor = vec4(final_color,1.);
}