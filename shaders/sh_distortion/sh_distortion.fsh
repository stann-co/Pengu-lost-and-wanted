//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D s_Mask;
uniform float u_Delta;

float rand(float n) {
	return fract(sin(n) * 43758.5453123);
}

vec3 noise(float t){
	const vec2 res = vec2(480.,270.);
	vec2 uv = gl_FragCoord.xy / res.xy * 1.1;
	return vec3(sin(rand(uv.x * (t + 250.0) - uv.y * (t + 2125.0))), sin(rand(uv.x * (t + 80.0) + uv.y * (t + 1.0) )), sin(rand(uv.x * (t + 8.0) - uv.y * (t + 32.0) )));
}

void main()
{
	
	float mask = texture2D( s_Mask, v_vTexcoord).r;
	
	vec2 normal = noise(u_Delta).xy;
	normal = (normal - 0.5) * 2.0;

	vec4 col = texture2D( gm_BaseTexture, (v_vTexcoord + normal*mask) );
	
	gl_FragColor.rgb = col.rgb;
	gl_FragColor.a = 1.;
}
