varying vec3 v_normal;
varying vec4 v_color;

void main() {
   vec3 ambient_color = vec3(0.1, 0.1, 0.1);
   vec3 light_color = vec3(1.0,1.0,1.0);
   
   vec3 L = normalize(vec3(0.0,0.5,0.0));
   float NdotL = max(0.0, -dot(v_normal, L));
   vec3 diffuse_color = NdotL * light_color;
   
   vec3 final_color = v_color.rgb * (ambient_color + diffuse_color);
    gl_FragColor = vec4(final_color, v_color.a);
}