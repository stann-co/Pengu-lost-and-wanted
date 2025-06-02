//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec2 v_vPosition;

uniform float u_depth;
uniform float u_offset;
uniform float u_offset2;

uniform sampler2D s_tilemap_fx;
uniform sampler2D s_Texture;

uniform vec2 u_cam_offset;



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
    vec2 res = vec2(480+32,270+32);
    
    float numLayers = 32.;
     
    float depthMax = 2.;//u_depth + 1.0; // 1 to 2
    float depthMin = 0.5;//1.0 - u_depth; // 1 to 0
    
    float currentDepth = depthMin;
    float depthScaled = mix(1.,currentDepth,u_depth);
    
    vec2 pixel_offset = (mod(u_cam_offset,depthScaled)/res);
    vec2 UVs = ScaleCenter(v_vTexcoord, mix(1.,currentDepth,u_depth));
    UVs -= pixel_offset;
    
    float depthMap = (texture2D(s_tilemap_fx, UVs).w) * 2.;
     
    //every pixel starts with a minimum depth, and continously goes forward, until it "hits" the depthmap
    for(float i = 0.; i <= numLayers; i+=1.){
        
        if(currentDepth >= depthMap) break;  
        
        currentDepth = mix(depthMin,depthMax,i/numLayers);
        depthScaled = mix(1.,currentDepth,u_depth);
        
        UVs = ScaleCenter(v_vTexcoord, depthScaled);
        pixel_offset = (mod(u_cam_offset,depthScaled)/res);
        UVs -= pixel_offset;
        
        depthMap = (texture2D(s_tilemap_fx, UVs).w) * 2.;
        
    }
    
    if(UVs.x > 1.0 || UVs.y > 1.0 || UVs.x < 0.0 || UVs.y < 0.0)
		discard;
    
    
    ///Shine
    vec2 normal = texture2D( gm_BaseTexture, UVs ).xy;
    vec2 roughness = texture2D( gm_BaseTexture, UVs ).z; 
    
        vec3 texture = texture2D( s_Texture, mod((v_vPosition / u_dimensions) * u_texture_scale + u_texture_offset + normal,1.0)).rgb;
    
    
    
    vec4 final = texture2D( gm_BaseTexture, UVs );
    gl_FragColor = final;
    
    
    
    
    
    
    ////debugging uvs
    //vec4 test = vec4(0.);
    //test.a = 1.;
    //
    //test.xyz = vec3(depthMap);
    //
    ////gl_FragColor = test;
    
}