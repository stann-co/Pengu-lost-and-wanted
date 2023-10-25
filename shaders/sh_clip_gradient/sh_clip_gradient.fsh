//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float percentage;
uniform vec3 color1;
uniform vec3 color2;

void main()
{
    vec4 color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	float value = color.r;
	
	if(value > percentage)
	{
		color = vec4(color1.r,color1.g,color1.b,1.0);
	}
	else
	{
		color = vec4(color2.r,color2.g,color2.b,1.0);
	}
	
	gl_FragColor = color;
}
