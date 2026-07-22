//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

const vec3 RED  = vec3(1.,0.,0.);
const vec3 BLUE = vec3(0.,0.75,1.);

void main()
{
    vec4 final = vec4(1.);
    final.rgb = mix(RED,BLUE,v_vTexcoord.x);
    gl_FragColor = final;
}
