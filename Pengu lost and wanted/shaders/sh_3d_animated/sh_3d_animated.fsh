
////////Varying///////////////////

varying vec2 v_vTexcoord;
varying vec3 v_vNormal;

void main()
{
    gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord);

	//gl_FragColor.rgb = v_vNormal;
}