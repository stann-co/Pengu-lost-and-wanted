//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;

vec3 quantize(vec3 color, float levels) {
    return floor(color * levels) / (levels - 1.0);
}

vec3 dither(vec3 color, float dither_amount, float levels) {
    int x = int(mod(v_vPosition.x, 2.0));
    int y = int(mod(v_vPosition.y, 2.0));
    int index = x + y * 2;
    float bayer[4];
    bayer[0] = 1.;
    bayer[1] = 0.;
    bayer[2] = 0.;
    bayer[3] = 1.0;
    
    float pattern = (bayer[index]);
    
    color.rgb += vec3(pattern * (1./255.) * dither_amount);
    
    return quantize(color,levels);
}

void main()
{
    vec4 col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    col.rgb = dither(col.rgb,1.,32.);
    
    gl_FragColor = col;
}
