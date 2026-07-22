varying vec2 vTexcoord;
varying vec4 vColour;
varying vec3 vNormal;
varying vec3 vViewNormal;

void main()
{
	vec4 col = vColour;
	col *= texture2D( gm_BaseTexture, vTexcoord);
	
	vec2 matcap_uv = vViewNormal.xy * 0.5 + 0.5;   
    vec3 matcap_color = texture2D(gm_BaseTexture, matcap_uv).rgb;
	
	
    gl_FragColor = vec4(matcap_color, 1.);
}
