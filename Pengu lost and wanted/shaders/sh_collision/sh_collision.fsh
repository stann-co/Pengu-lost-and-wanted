//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
uniform int u_layer; // 0 = RED, 1 = BLUE, 2 = GREEN
uniform int u_active; // 0 = RED, 1 = BLUE, 2 = GREEN
uniform bool u_show; // hide or not

void main()
{
	if (u_show == false){
		return;	
	}
	
	vec3 color;
	if(u_layer == 0){
		color = vec3(1.0,0.5,0.5);
	} else if(u_layer == 1){
		color = vec3(0.5,1.0,0.5);
	} else if(u_layer == 2){
		color = vec3(0.5,0.5,1.0);
	}
	
	float opacity = 0.8;
	if(u_active != -1 && u_layer != u_active){
		opacity = 0.6;	
	}
	
    gl_FragColor = vec4(color,opacity) * texture2D( gm_BaseTexture, v_vTexcoord );
}
