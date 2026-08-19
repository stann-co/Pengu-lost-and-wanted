//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec2 v_vPosition;

uniform float u_depth;
uniform float u_offset;
uniform float u_offset2;

uniform float u_roughness;
uniform float u_normal;

uniform float u_texture_scale;
uniform float u_texture_offset_scale;

uniform sampler2D s_tilemap_fx;
uniform sampler2D s_texture;

uniform vec2 u_cam_offset;

const vec2 res = vec2(480+32,270+32);



vec2 ScaleCenter(vec2 uv, float scale)
{
    return (uv - 0.5) * (scale) + 0.5;
}

float blendScreen(float base, float blend) {
	return 1.0-((1.0-base)*(1.0-blend));
}

vec3 blendScreen(vec3 base, vec3 blend) {
	return vec3(blendScreen(base.r,blend.r),blendScreen(base.g,blend.g),blendScreen(base.b,blend.b));
}

vec3 blendScreen(vec3 base, vec3 blend, float opacity) {
	return (blendScreen(base, blend) * opacity + base * (1.0 - opacity));
}

void main()
{
    ////Depth
    
    float numLayers = 32.;
     
    float depthMax = 2.;//u_depth + 1.0; // 1 to 2
    float depthMin = 0.5;//1.0 - u_depth; // 1 to 0
    
    float currentDepth = depthMin;
    float depthScaled = mix(1.,currentDepth,u_depth);
    
    vec2 pixel_offset = (mod(u_cam_offset,depthScaled)/res);
    vec2 UVs = ScaleCenter(v_vTexcoord, mix(1.,currentDepth,u_depth));
    UVs -= pixel_offset;
    
    float depthMap = (texture2D(s_tilemap_fx, UVs).z) * 2.;
     
    //every pixel starts with a minimum depth, and continously goes forward, until it "hits" the depthmap
    for(float i = 0.; i <= numLayers; i+=1.){
        
        if(currentDepth >= depthMap) break;  
        
        currentDepth = mix(depthMin,depthMax,i/numLayers);
        depthScaled = mix(1.,currentDepth,u_depth);
        
        UVs = ScaleCenter(v_vTexcoord, depthScaled);
        pixel_offset = (mod(u_cam_offset,depthScaled)/res);
        UVs -= pixel_offset;
        
        depthMap = (texture2D(s_tilemap_fx, UVs).z) * 2.;
        
    }
    
    if(UVs.x > 1.0 || UVs.y > 1.0 || UVs.x < 0.0 || UVs.y < 0.0)
		discard;
    
    
    vec4 diffuse = texture2D( gm_BaseTexture, UVs);
    
    vec2 normal = texture2D( s_tilemap_fx, UVs ).xy * u_normal;
    
    float roughness = texture2D( s_tilemap_fx, UVs ).w * u_roughness;
    
    vec2 tex_uvs = mod((v_vPosition / res) * u_texture_scale + (u_cam_offset * u_texture_offset_scale)/res + normal,1.0);
    
    vec3 texture = texture2D( s_texture,tex_uvs + (UVs - v_vTexcoord)).rgb;

    vec3 blended = blendScreen(diffuse.rgb,texture,roughness);
    
    vec4 final = vec4(1.);
    final.rgb = blended;
    final.a = diffuse.a;
    
    gl_FragColor = final;
    
}