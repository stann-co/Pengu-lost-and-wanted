//
// Simple passthrough fragment shader
//
varying vec4 v_vColour;

uniform float u_length;
uniform float u_time;

void main()
{
    float size = 16.0 / u_length;
    float offset = (u_time / u_length) / 50.0;
	
	//offset
	float gradient = mod(v_vColour.r+offset,1.0);
	
	//checker
	float checker = mod(gradient,size)/size;
	checker = step(checker,0.5);
	
    vec4 color = v_vColour;
	color.rgb = vec3(checker);
    
    gl_FragColor = color;
}
