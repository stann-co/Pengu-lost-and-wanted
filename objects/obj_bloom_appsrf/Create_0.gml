/// @description Init
event_inherited();

//-----------------------------------------------------------------------------
#region TITLE, INFO, CORNER, CLICK (optional):
//-----------------------------------------------------------------------------
title_text	= @"Bloom AppSrf";

info_text	= @"Bloom AppSrf:

				Based on a 2xN Gaussian blur with linear interpolated samples.
				
				1. Draw bright colours of the application surface to a bloom surface.
				2. Blur the bloom surface.
				3. Add the bloom surface to the application surface.";

corner_text	= "";			// if wanted/needed, update this in a step or draw event

click_region_gui	= true; // false: mouse click region in room space | true: mouse click region in gui space
deselectable		= false;	// Allow deselecting by clicking on the module again
#endregion
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
#region SPRITE & SHADER (mandatory):
//-----------------------------------------------------------------------------
shader_bloom_lum		= shd_bloom_filter_luminance;
u_bloom_threshold		= shader_get_uniform(shader_bloom_lum, "bloom_threshold");
u_bloom_range			= shader_get_uniform(shader_bloom_lum, "bloom_range");

shader_blur				= shd_blur_2_pass_gauss_lerp;
u_blur_steps			= shader_get_uniform(shader_blur, "blur_steps");
u_sigma					= shader_get_uniform(shader_blur, "sigma");
u_blur_vector			= shader_get_uniform(shader_blur, "blur_vector");
u_texel_size			= shader_get_uniform(shader_blur, "texel_size");

shader_bloom_blend		= shd_bloom_blend;
u_bloom_intensity		= shader_get_uniform(shader_bloom_blend, "bloom_intensity");
u_bloom_darken			= shader_get_uniform(shader_bloom_blend, "bloom_darken");
u_bloom_saturation		= shader_get_uniform(shader_bloom_blend, "bloom_saturation");
u_bloom_texture			= shader_get_sampler_index(shader_bloom_blend, "bloom_texture");

bloom_texture			= -1;
srf_ping				= -1;
srf_pong				= -1;

gui_w					= display_get_gui_width();
gui_h					= display_get_gui_height();

app_w					= gui_w / 3;
app_h					= gui_h / 3;

texel_w					= 1 / app_w;
texel_h					= 1 / app_h;

application_surface_draw_enable(false);
#endregion
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
#region GUI:
//-----------------------------------------------------------------------------
var slider = 0;
slider_set_caption(slider++, "Blur Steps");
slider_set_caption(slider++, "Blur Sigma");
slider_set_caption(slider++, "Threshold");
slider_set_caption(slider++, "Range");
slider_set_caption(slider++, "Intensity");
slider_set_caption(slider++, "Darken");
slider_set_caption(slider++, "Saturation");

slider = 0;
slider_set_value(slider++, 0.35);
slider_set_value(slider++, 0.2);
slider_set_value(slider++, 0.35);
slider_set_value(slider++, 0.1);
slider_set_value(slider++, 0.5);
slider_set_value(slider++, 0);
slider_set_value(slider++, 0.5);

var slider_max = slider;
for (slider = 0; slider < slider_max; slider++) slider_set_draw_value(slider, false);
#endregion
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
#region CREATE SCROLLING MOCKUP (optional)
//-----------------------------------------------------------------------------
scr_use_template_mockup(mockup.gothicvaniatown_lo_res);
#endregion
//-----------------------------------------------------------------------------
