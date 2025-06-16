//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

const vec3 red  = vec3(1.,0.,0.);
const vec3 blue = vec3(0.,0.75,1.);

void main()
{
    vec4 final = vec4(1.);
    final.rgb = mix(red,blue,v_vTexcoord.x);
    gl_FragColor = final;
}
