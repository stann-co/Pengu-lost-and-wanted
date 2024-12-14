//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
     vec4 color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	 color.a = v_vTexcoord.y;
	 gl_FragColor = color;
}
