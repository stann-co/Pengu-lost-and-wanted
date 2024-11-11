/// @description

var leg_upper_x_r = lerp(body.x + vec_leg_r.x,foot_r.x_knee,0.5);
var leg_upper_y_r = lerp(body.y + vec_leg_r.y,foot_r.y_knee,0.5);

var leg_lower_x_r = lerp(foot_r.x,foot_r.x_knee,0.5);
var leg_lower_y_r = lerp(foot_r.y -foot_height,foot_r.y_knee,0.5);


var leg_upper_x_l = lerp(body.x + vec_leg_l.x,foot_l.x_knee,0.5);
var leg_upper_y_l = lerp(body.y + vec_leg_l.y,foot_l.y_knee,0.5);

var leg_lower_x_l = lerp(foot_l.x,foot_l.x_knee,0.5);
var leg_lower_y_l = lerp(foot_l.y -foot_height,foot_l.y_knee,0.5);

draw_set_color(red);

////right leg
draw_sprite(spr_mech_foot,0,foot_r.x,foot_r.y);
////draw upper leg
//draw_marble(leg_upper_x_r,leg_upper_y_r,6)
draw_sprite(spr_mech_ball,1,leg_upper_x_r,leg_upper_y_r)


////draw lower leg
//draw_marble(leg_lower_x_r,leg_lower_y_r,6)
draw_sprite(spr_mech_ball,1,leg_lower_x_r,leg_lower_y_r)

////draw knee
//draw_marble(foot_r.x_knee,foot_r.y_knee,7)
draw_sprite(spr_mech_ball,0,foot_r.x_knee,foot_r.y_knee)



#region Dome

//var origin_x = sprite_get_xoffset(spr_mech_body);
//var origin_y = sprite_get_yoffset(spr_mech_body);
draw_sprite_ext(spr_mech_body,0,dome.x,dome.y,1,1,-body_angle_component,white,1); //dome inside

var chair_offset = -8
var pengu_offset = -5
var dash_offset  = 14
var sprite_xscale = mirror_component > 0 ? 1 : -1;
draw_sprite_ext(spr_mech_body,1,dome.x + chair_offset * mirror_component,dome.y,sprite_xscale,1,-body_angle_component,white,1); //chair
draw_sprite_ext(spr_mech_body,2,dome.x + pengu_offset * mirror_component,dome.y,sprite_xscale,1,-body_angle_component,white,1); //pengu
draw_sprite_ext(spr_mech_body,3,dome.x + dash_offset  * mirror_component,dome.y,sprite_xscale,1,-body_angle_component,white,1); //dashboard



//draws dice
draw_set_color(black);
die1.draw();
die2.draw();
var p1 = die1.get_last_point();
draw_sprite(spr_fuzzy_die,0,p1.x,p1.y);

var p2 = die2.get_last_point();
draw_sprite(spr_fuzzy_die,1,p2.x,p2.y);

draw_set_color(white);


#endregion

//draws body
draw_sprite_ext(spr_mech_body,4,body.x,body.y,1,1,-body_angle_component,white,1);
//draw_sprite_ext_cubemap(spr_mech_body,4,body.x,body.y,spr_mech_body_normal,spr_reflection_2,spr_mech_body_roughness,normal_strength,roughness_strength,reflection_scale,-0.25,1,1,-body_angle_component);

draw_set_color(green);

////left leg
draw_sprite(spr_mech_foot,1,foot_l.x,foot_l.y);
////draw upper leg
//draw_marble(leg_upper_x_l,leg_upper_y_l,6)
draw_sprite(spr_mech_ball,1,leg_upper_x_l,leg_upper_y_l)

////draw lower leg
//draw_marble(leg_lower_x_l,leg_lower_y_l,6)
draw_sprite(spr_mech_ball,1,leg_lower_x_l,leg_lower_y_l)

////draw knee
//draw_marble(foot_l.x_knee,foot_l.y_knee,7)
draw_sprite(spr_mech_ball,0,foot_l.x_knee,foot_l.y_knee)




draw_set_color(white);

