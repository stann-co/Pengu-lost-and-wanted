//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_transition;

float snap(float value, float step) {
    return floor(value / step + 0.5) * step;
}

vec3 quantizeColor(vec3 color, float levels) {
    float stepped = 1.0 / levels;
    return vec3(snap(color.r, stepped), snap(color.g, stepped), snap(color.b, stepped));
}

void main()
{
    vec4 base = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);

    // Quantize the base color based on transition level
    float quantizationLevels = mix(16.0, 4.0, snap(u_transition,0.05)); // Adjust levels from 64 to 2
    vec3 quantizedColor = quantizeColor(base.rgb, quantizationLevels);

    // Blend quantized colors based on transition value
    gl_FragColor = vec4(quantizedColor, base.a);
}