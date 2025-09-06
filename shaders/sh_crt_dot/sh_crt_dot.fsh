//
// CRT dot pattern shader
// STANN.co
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_resolution; //resolution
uniform float u_scale; //scale of the effect
uniform float u_radius; //radius of invidivdual circles
uniform float u_sharpness; //sharpness of circles

float ratio = u_resolution.x / u_resolution.y;

vec2 tile(vec2 st, float zoom){
    st *= zoom;
    return fract(st);
}

vec3 circle(vec2 st, vec3 col){
    vec2 pos = vec2(0.5)-st; // get center pixel color from this maybe
    float val = 1.-smoothstep(u_radius-(u_radius*u_sharpness),u_radius+(u_radius*u_sharpness),dot(pos,pos)*3.14);
	
	vec2 scale = vec2(ratio,1.)*u_scale;
		
	//if there is a better way to get just the color of the center of the circle, please let me know
	vec2 cords = v_vTexcoord;
	cords += (pos/(scale*3.));
	vec3 base_col = texture2D( gm_BaseTexture,cords).rgb;
	
    return vec3(val,val,val) * base_col * col;
}

vec3 circle_row(vec2 _st){
    _st.x *= 3.;
    _st.y *= 2.488;
    
    return
        circle(_st+vec2( 3.,-1. ), vec3(1.,0.,0.))+
		circle(_st+vec2( 2.,-1.), vec3(0.,1.,0.))+
 	    circle(_st+vec2( 1.,-1.),  vec3(0.,0.,1.))+
		circle(_st+vec2( 0.,-1. ), vec3(1.,0.,0.))+
		circle(_st+vec2(-1.,-1.), vec3(0.,1.,0.))+
 	    circle(_st+vec2(-2.,-1.),  vec3(0.,0.,1.))+
        circle(_st+vec2(-3.,-1.), vec3(1.,0.,0.))+
		circle(_st+vec2(-4.,-1.), vec3(0.,1.,0.))+
 	    circle(_st+vec2(-5.,-1.),  vec3(0.,0.,1.));
}

vec3 crt_pattern(vec2 _st){
    _st.y *= 0.672;
    float offset = 1./3.;
    return
        circle_row(_st+vec2(-0.5,offset*3.))+
        circle_row(_st+vec2(0.,offset*2.))+
        circle_row(_st+vec2(0.5,offset))+
    	circle_row(_st+vec2(0.))+
    	circle_row(_st+vec2(0.5,-offset))+
    	circle_row(_st+vec2(0.,-offset*2.));
}

void main()
{
    vec2 st = v_vTexcoord;
	st.x *= ratio;
    vec2 grid1 = tile(vec2(st.x,st.y*=1.808),u_scale);
    vec3 color = crt_pattern(grid1);
	
	gl_FragColor = vec4(color,1.0);
}
