varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec3 u_size;//width,height,radius

const int DIRECTIONS = 8;
const float PI2 = 6.28318530718;

void main()
{
    vec2 radius = u_size.z / u_size.xy;
    vec4 color = texture2D(gm_BaseTexture, v_vTexcoord) * 4.0;
    float total = 4.0;

    for (int i = 0; i < DIRECTIONS; i++)
    {
        float angle = PI2 * float(i) / float(DIRECTIONS);
        vec2 dir = vec2(cos(angle), sin(angle));

        color += texture2D(gm_BaseTexture, v_vTexcoord + dir * radius * 0.5) * 2.0;
        color += texture2D(gm_BaseTexture, v_vTexcoord + dir * radius);
        total += 3.0;
    }

    color /= total;
    gl_FragColor = color * v_vColour;
}
