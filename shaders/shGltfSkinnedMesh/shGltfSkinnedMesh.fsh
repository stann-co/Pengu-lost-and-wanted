varying vec2 vTexcoord;
varying vec4 vColour;
varying vec3 vNormal;

void main()
{
    vec3 norm = .5 * (vNormal + vec3(1.));
    gl_FragColor = vec4(norm, 1.);
}