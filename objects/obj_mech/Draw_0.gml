/// @description

var leg_upper_x_r_ = lerp(body.x + vec_leg_r.x,foot_r.x_knee,0.5);
var leg_upper_y_r_ = lerp(body.y + vec_leg_r.y,foot_r.y_knee,0.5);

var leg_lower_x_r_ = lerp(foot_r.x,foot_r.x_knee,0.5);
var leg_lower_y_r_ = lerp(foot_r.y -foot_height,foot_r.y_knee,0.5);


var leg_upper_x_l_ = lerp(body.x + vec_leg_l.x,foot_l.x_knee,0.5);
var leg_upper_y_l_ = lerp(body.y + vec_leg_l.y,foot_l.y_knee,0.5);

var leg_lower_x_l_ = lerp(foot_l.x,foot_l.x_knee,0.5);
var leg_lower_y_l_ = lerp(foot_l.y -foot_height,foot_l.y_knee,0.5);

draw_set_color(RED);

////right_ leg
draw_sprite(spr_mech_foot,0,foot_r.x,foot_r.y);
////draw upper leg
//draw_marble(leg_upper_x_r_,leg_upper_y_r_,6)
draw_sprite(spr_mech_ball,1,leg_upper_x_r_,leg_upper_y_r_)


////draw lower leg
//draw_marble(leg_lower_x_r_,leg_lower_y_r_,6)
draw_sprite(spr_mech_ball,1,leg_lower_x_r_,leg_lower_y_r_)

////draw knee
//draw_marble(foot_r.x_knee,foot_r.y_knee,7)
draw_sprite(spr_mech_ball,0,foot_r.x_knee,foot_r.y_knee)



#region Dome

//var origin_x = sprite_get_xoffset(spr_mech_body);
//var origin_y = sprite_get_yoffset(spr_mech_body);
draw_sprite_ext(spr_mech_body,0,dome.x,dome.y,1,1,-body_angle_component,WHITE,1); //dome inside

var chair_offset_ = -8
var pengu_offset_ = -5
var dash_offset_  = 14
var sprite_xscale_ = mirror_component > 0 ? 1 : -1;
draw_sprite_ext(spr_mech_body,1,dome.x + chair_offset_ * mirror_component,dome.y,sprite_xscale_,1,-body_angle_component,WHITE,1); //chair

if(controlled){
    draw_sprite_ext(spr_mech_body,2,dome.x + pengu_offset_ * mirror_component,dome.y,sprite_xscale_,1,-body_angle_component,WHITE,1); //pengu
}

draw_sprite_ext(spr_mech_body,3,dome.x + dash_offset_  * mirror_component,dome.y,sprite_xscale_,1,-body_angle_component,WHITE,1); //dashboard



//draws dice
draw_set_color(BLACK);
die1.draw();
die2.draw();
var p1_ = die1.get_last_point();
draw_sprite(spr_fuzzy_die,0,p1_.x,p1_.y);

var p2_ = die2.get_last_point();
draw_sprite(spr_fuzzy_die,1,p2_.x,p2_.y);

draw_set_color(WHITE);


#endregion

//draws body
draw_sprite_ext(spr_mech_body,4,body.x,body.y,1,1,-body_angle_component,WHITE,1);
//draw_sprite_ext_cubemap(spr_mech_body,4,body.x,body.y,spr_mech_body_normal,spr_reflection_2,spr_mech_body_roughness,normal_strength,roughness_strength,reflection_scale,-0.25,1,1,-body_angle_component);

draw_set_color(GREEN);

////left_ leg
draw_sprite(spr_mech_foot,1,foot_l.x,foot_l.y);
////draw upper leg
//draw_marble(leg_upper_x_l_,leg_upper_y_l_,6)
draw_sprite(spr_mech_ball,1,leg_upper_x_l_,leg_upper_y_l_)

////draw lower leg
//draw_marble(leg_lower_x_l_,leg_lower_y_l_,6)
draw_sprite(spr_mech_ball,1,leg_lower_x_l_,leg_lower_y_l_)

////draw knee
//draw_marble(foot_l.x_knee,foot_l.y_knee,7)
draw_sprite(spr_mech_ball,0,foot_l.x_knee,foot_l.y_knee)




draw_set_color(WHITE);

