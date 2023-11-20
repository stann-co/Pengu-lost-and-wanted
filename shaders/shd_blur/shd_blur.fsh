/*-----------------------------------------------------------------------------
BLUR Fragment Shader:
1-PASS with discrete gaussian weighted samples (very inefficient)
-------------------------------------------------------------------------------
_______________________________________________________________________________
INFO:
-------------------------------------------------------------------------------
- Vertex Shader is a pass-though shader
- clamp:		remove clamp() if image is a sprite on its own
				texture page or a surface
					
_______________________________________________________________________________
UNIFORMS:
-------------------------------------------------------------------------------
- blur_steps:	how many pixels to blur to each side of the
				blur center. 5 steps => 11x11 kernel
- texel_size:	(image uv width) / (image pixel width)
				where image uv width is 1 if image is on a
				seperate texture page or is a surface
- uvs:			left x, top y, right x, bottom y
- sigma:		the gaussian sigma, try something from 0.2 to 0.5

_______________________________________________________________________________
EXAMPLE:
-------------------------------------------------------------------------------

Create event:
---------------------------------------
shader			= shd_blur_1-pass_gauss_discrete;
u_blur_steps	= shader_get_uniform(shader, "blur_steps");
u_uvs			= shader_get_uniform(shader, "uvs");
u_texel_size	= shader_get_uniform(shader, "texel_size");
u_sigma			= shader_get_uniform(shader, "sigma");

var uvs_all		= sprite_get_uvs(sprite_1, 0);
uvs				= [uvs_all[0], uvs_all[1], uvs_all[2], uvs_all[3]];
image_w			= sprite_get_width(sprite_1);
image_h			= sprite_get_height(sprite_1);
texel_w			= (uvs_all[2] - uvs_all[0]) / image_w;
texel_h			= (uvs_all[3] - uvs_all[1]) / image_h;

	
Draw event:
---------------------------------------
var blur_steps		= 5;
var sigma			= 0.3

shader_set(shader);

shader_set_uniform_f(u_blur_steps, blur_steps);			// half of the blur kernel size, whole number >= 1
shader_set_uniform_f_array(u_uvs, uvs);					// for clamping and pixel size
shader_set_uniform_f(u_texel_size, texel_w, texel_h);	// for pixel size
shader_set_uniform_f(u_sigma, sigma);					// lower sigma: less blur, but less blocky

draw_sprite(spr_whatever, 0, x, y);

shader_reset();
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float	blur_steps;
uniform vec2	texel_size;
uniform float	sigma;
uniform vec4	uvs;

float weight(vec2 pos) { // Gauss 2D
	return exp(-(pos.x * pos.x + pos.y * pos.y) / (2.0 * sigma * sigma));
}


void main()
{
    highp vec4 blurred_col	= vec4(0.0);
	
	vec2  offset, sample;
	float sample_weight;
	float total_weight	= 0.0;
	float kernel		= 2.0 * blur_steps + 1.0;
	
	for (offset.x = -blur_steps; offset.x <= blur_steps; offset.x++) {
		for (offset.y = -blur_steps; offset.y <= blur_steps; offset.y++) {
			sample_weight	= weight(offset/kernel);
			total_weight	+= sample_weight;
			
			sample			= clamp(v_vTexcoord + offset * texel_size, uvs.xy, uvs.zw);
			blurred_col		+= texture2D(gm_BaseTexture, sample) * sample_weight;
		}	
	}
	
	gl_FragColor = v_vColour * blurred_col / total_weight;
}
