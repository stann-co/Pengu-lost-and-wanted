//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec2 v_vPosition;

uniform sampler2D s_Texture;

uniform float u_normal_strength;
uniform float u_roughness_strength;
uniform float u_texture_scale;
uniform float u_opacity;

uniform vec2 u_dimensions;
uniform vec2 u_texture_offset;


uniform vec2 u_texcoord_n; //offset from the basetexture teccoord
uniform vec2 u_texcoord_r; 

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
	vec2 normal;
	
	if(u_texcoord_n.x != -1.0){
		normal = texture2D( gm_BaseTexture, v_vTexcoord - u_texcoord_n).rg;
	} else {
		normal = vec2(0.502, 0.502);
	}
	normal = (normal - 0.5) * 2.0 * u_normal_strength;
	
	float roughness;
	if(u_texcoord_r.x != -1.0){
		roughness = texture2D( gm_BaseTexture, v_vTexcoord - u_texcoord_r).r;
	} else {
		roughness = 1.0;
	}
	
	vec3 texture = texture2D( s_Texture, mod((v_vPosition / u_dimensions) * u_texture_scale + u_texture_offset + normal,1.0)).rgb;
	vec4 basecol = texture2D( gm_BaseTexture, v_vTexcoord);
	
	vec3 blended = blendScreen(basecol.rgb,texture,roughness * u_roughness_strength);

	vec4 final = vec4(1.0,1.0,1.0,1.0);
	final.rgb = blended;
	final.a = basecol.a * u_opacity;

	gl_FragColor = final;
}
