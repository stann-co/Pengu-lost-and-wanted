/// @description Init
event_inherited();

//-----------------------------------------------------------------------------
#region TITLE, INFO, CORNER, CLICK (optional):
//-----------------------------------------------------------------------------
title_text	= @"Blur 2:
				NxN, Gauss, Discrete
				ultra slow, smooth";

info_text	= @"Blur 2: NxN, Gauss, Discrete:

				Blurs all pixels in a NxN kernel with a gaussian weight distribution in one pass.
				Calculating a NxN kernel in one pass is very inefficient, especially with larger kernels.
				
				The gaussian weights smooth the blur.";

corner_text	= "";			// if wanted/needed, update this in a step or draw event

click_region_gui	= true; // false: mouse click region in room space | true: mouse click region in gui space
deselectable		= true;	// Allow deselecting by clicking on the module again
#endregion
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
#region SPRITE & SHADER (mandatory):
//-----------------------------------------------------------------------------
sprite			= spr_dummy_256x256px; // optional
sprite_blur		= spr_foto_sunset_1440x768px;

shader			= shd_blur_1_pass_gauss_discrete;
u_blur_steps	= shader_get_uniform(shader, "blur_steps");
u_sigma			= shader_get_uniform(shader, "sigma");
u_texel_size	= shader_get_uniform(shader, "texel_size");
u_uvs			= shader_get_uniform(shader, "uvs");

var uvs_all		= sprite_get_uvs(sprite_blur, 0);
uvs				= [uvs_all[0], uvs_all[1], uvs_all[2], uvs_all[3]];

image_w			= sprite_get_width(sprite_blur);
image_h			= sprite_get_height(sprite_blur);

texel_w			= (uvs_all[2] - uvs_all[0]) / image_w;
texel_h			= (uvs_all[3] - uvs_all[1]) / image_h;

slider_set_caption(0, "Kernel");
slider_set_draw_value(0, false);
slider_set_value(0, 0);

slider_set_caption(1, "Sigma");
slider_set_draw_value(1, false);
slider_set_value(1, 0.5);

#endregion
//-----------------------------------------------------------------------------
