//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D s_Normal;
uniform sampler2D s_Texture;
uniform sampler2D s_Roughness;

uniform float u_normal_strength;
uniform float u_roughness_strength;

uniform vec2 u_texture_ratio;
uniform vec2 u_texture_offset;
uniform vec2 u_texture_scale;

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
	vec2 normal = texture2D( s_Normal, v_vTexcoord).rg;
	normal = (normal - 0.5) * 2.0 * u_normal_strength;


	vec2 offset = u_texture_offset * u_texture_ratio;
	
	vec3 texture = texture2D( s_Texture, ( (v_vTexcoord+normal+offset)*u_texture_scale)).rgb;
	
	float roughness = texture2D( s_Roughness, v_vTexcoord).r;
	
	vec4 basecol = texture2D( gm_BaseTexture, v_vTexcoord);
	
	vec3 blended = blendScreen(basecol.rgb,texture,roughness * u_roughness_strength);

	vec4 final = vec4(1.0,1.0,1.0,1.0);
	final.rgb = blended;
	final.a = basecol.a;

	gl_FragColor = final;
}
