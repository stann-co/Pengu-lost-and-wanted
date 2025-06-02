//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_texcoord_n;
uniform vec2 u_texcoord_r;
uniform vec2 u_texcoord_d;

void main()
{
    
    vec4 maps = vec4(0.);
    
    if(u_texcoord_r.x != -1.){ //roughness
        maps.z = texture2D( gm_BaseTexture, v_vTexcoord - u_texcoord_r).x;
    } else maps.z = 1.;
    
    
    if(u_texcoord_n.x != -1.){ //normal
        maps.xy = texture2D( gm_BaseTexture, v_vTexcoord - u_texcoord_n).xy;
    } else {
        maps.xy = vec2(0.502, 0.502);
    }
    
    if(u_texcoord_d.x != -1.){ //depth
        maps.w = texture2D( gm_BaseTexture, v_vTexcoord - u_texcoord_d).x; //depth
    } else maps.w = 0.;
    
    
    gl_FragColor = maps;
}
