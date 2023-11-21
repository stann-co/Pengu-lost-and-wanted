/// @description MAIN

// SET VALUES:
//-----------------------------------------------------------------------------
var blur_steps		= round(slider_get_value(0) * 31) + 1;
var sigma			= max(slider_get_value(1), 0.0001); // div by 0


// DRAW:
//-----------------------------------------------------------------------------
if (global.selected_module == id) { // don't draw if another module is selected
	shader_set(shader);
		shader_set_uniform_f(u_blur_steps,		blur_steps);
		shader_set_uniform_f(u_texel_size,		texel_w, texel_h);
		shader_set_uniform_f(u_sigma,			sigma);
		shader_set_uniform_f_array(u_uvs,		uvs);
		draw_sprite(sprite_blur, 0, 0, 0);
	shader_reset();
}


var kernel			= blur_steps * 2 + 1;
var kernel_squared	= kernel * kernel;
var samplesPerImage	= kernel_squared * image_w * image_h;

corner_text	=	"Steps: "				+ string(blur_steps) +
				"\nKernel: "			+ string(kernel) + " x " + string(kernel) +
				"\nSigma: "				+ string(sigma) +
				"\n\nSamples/px: "		+ string(kernel_squared) +
				"\nSamples/img: "		+ string(samplesPerImage);
