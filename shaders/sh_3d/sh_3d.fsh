//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
//varying vec4 v_color;

uniform sampler2D s_texture;

void main()
{	 
    vec4 color = texture2D(s_texture,v_vTexcoord);// * v_color;
    gl_FragColor = color;
	
}
