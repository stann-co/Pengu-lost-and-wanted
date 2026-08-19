//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D s_texture;
uniform vec4 u_uvs;
uniform float u_refract;
uniform float u_amount;

void main()
{
	
	vec4 color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	vec2 size = vec2(u_uvs[2] - u_uvs[0],u_uvs[3] - u_uvs[1]);
	vec2 uv = vec2(u_uvs.x,u_uvs.y);
	
	vec2 coord = ((v_vTexcoord - uv) / size)*1.2;
	
	vec4 sample = texture2D( s_texture, coord + vec2(color.g,color.b) * (u_refract) - u_refract *0.5);
	
	
	//float gray = dot(sample, vec4(0.299, 0.587, 0.114, 0.0));

	//vec4 shade = vec4(gray * sample.rgb, color.a);
	sample.a = color.a;
	color = mix(sample, color, u_amount);
	
	//color.rgb *= u_brightness;
	
	gl_FragColor = color;
	
}
