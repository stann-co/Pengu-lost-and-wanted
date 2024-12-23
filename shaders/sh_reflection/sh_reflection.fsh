//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;

uniform float u_time;
uniform vec3 u_tint;
uniform float u_brightness;
uniform float u_distortion;
uniform vec2 u_scale; // Scale of the noise
uniform vec2 u_speed; // offset speed
uniform vec2 u_size; // Scale of the sprite

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise(vec2 p) {
    vec2 i = floor(p);  // Integer part
    vec2 f = fract(p);  // Fractional part

    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

void main()
{
	float noisy = noise(v_vPosition.xy*u_scale + u_speed * u_time);
	vec2 coords = vec2(v_vTexcoord.x, v_vTexcoord.y + (noisy * u_distortion - u_distortion * 0.5)/u_size.y);
	
	vec4 tex = v_vColour * texture2D( gm_BaseTexture, coords);
	float gray = dot(tex, vec4(0.299, 0.587, 0.114, 0.0));

	vec4 shade = vec4(gray * u_tint.rgb, tex.a);
	vec4 color = mix(shade, tex, 0.5);
	
	color.rgb *= u_brightness;
	
    gl_FragColor = color;
}