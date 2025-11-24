//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_resolution;
uniform float u_t;

// 2x2 Bayer matrix (values between 0.0 and 1.0)
float bayer2x2(vec2 p) {
    int x = int(mod(p.x, 2.0));
    int y = int(mod(p.y, 2.0));
    int index = x + y * 2;
    float bayer[4];
    bayer[0] = 1.;
    bayer[1] = 0.;
    bayer[2] = 0.;
    bayer[3] = 1.0;
    return bayer[index];
}

vec3 quantize(vec3 color, float levels) {
    return floor(color * levels) / (levels - 1.0);
}

//Typical pseudo-random hash (white noise).
float hash(vec2 p)
{
    p = mod(p, 7.31); //Bring 'p' to a useful range.
    //Generate a pseudo random number from 'p'.
    return fract(sin(p.x*12.9898 + p.y*78.233) * 43758.5453);
}

//Standard value noise.
float value_noise(vec2 pos)
{
    vec2 cell = floor(pos); //Cell (whole number) coordinates.
    vec2 sub = pos-cell; //Sub-cell (fractional) coordinates.
    sub *= sub*(3.-2.*sub); //Cubic interpolation (comment out for linear interpolation).
    const vec2 off = vec2(0,1); //Offset vector.

    //Sample cell corners and interpolate between them.
    return mix( mix(hash(cell+off.xx), hash(cell+off.yx), sub.x),
                mix(hash(cell+off.xy), hash(cell+off.yy), sub.x), sub.y);
}

//Generate 'fractal' noise from multiple value noise octaves.
float fractal_noise(vec2 pos, int oct, float amp)
{
    float noise_sum = 0.; //Noise total.
    float weight_sum = 0.; //Weight total.
    float weight = 1.; //Octave weight.

    for(int i = 0; i < oct; i++) //Iterate through octaves
    {
        noise_sum += value_noise(pos) * weight; //Add noise octave.
        weight_sum += weight; //Add octave weight.
        weight *= amp; //Reduce octave amplitude by multiplier.
        pos *= mat2(1.6,1.2,-1.2,1.6); //Rotate and scale.
    }
    return noise_sum/weight_sum; //Compute average.
}

void main() {
    float dither = bayer2x2(v_vTexcoord * u_resolution);
    
    vec2 ratio = vec2(1.,u_resolution.x/u_resolution.y);
    
    vec2 offset = vec2(u_t,0.)*0.005;
    
    vec2 warp = 1. - vec2(fractal_noise(v_vTexcoord+offset,4,0.1)) * 2.;
    warp *= ratio * 0.015;
    
    vec4 color = texture2D(gm_BaseTexture, v_vTexcoord + warp);
    
    //color.rgb = vec3(warp,0.);

    color.rgb += vec3((1./255.)*1.) * dither;
    
    color.rgb = quantize(color.rgb,32.0);
    
    gl_FragColor = color;
}

