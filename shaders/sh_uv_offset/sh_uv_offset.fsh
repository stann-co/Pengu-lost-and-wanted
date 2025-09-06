//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
uniform vec2 u_texcoord_uv;

void main()
{
    gl_FragColor = texture2D( gm_BaseTexture, v_vTexcoord - u_texcoord_uv);
}
