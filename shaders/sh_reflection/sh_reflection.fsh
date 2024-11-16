//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

float blendScreen(float base, float blend) {
	return 1.0-((1.0-base)*(1.0-blend));
}

vec3 blendScreen(vec3 base, vec3 blend) {
	return vec3(blendScreen(base.r,blend.r),blendScreen(base.g,blend.g),blendScreen(base.b,blend.b));
}

vec3 blendScreen(vec3 base, vec3 blend, float opacity) {
	return (blendScreen(base, blend) * opacity + base * (1.0 - opacity));
}


void main()
{
    vec4 refl = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	vec3 screen = blendScreen(refl.rgb,gl_FragColor.rgb,0.5);
	vec4 final = vec4(1.0);
	final.rgb = screen;
	final.a = refl.a;
	
	gl_FragColor = final;
}
