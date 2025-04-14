//normal
thruster_subimg += sprite_get_speed(spr_thruster);
normal_subimg += 0.5;

thrust1 = new Vector2(-30,19);
thrust2 = new Vector2(11,19);
thrust3 = new Vector2(-14,20);
thrust4 = new Vector2(28,20);

thrust1 = thrust1.rotated(-image_angle);
thrust2 = thrust2.rotated(-image_angle);
thrust3 = thrust3.rotated(-image_angle);
thrust4 = thrust4.rotated(-image_angle);

draw_thruster(x+thrust1.x,y+thrust1.y);
draw_thruster(x+thrust2.x,y+thrust2.y);
draw_thruster(x+thrust3.x,y+thrust3.y);
draw_thruster(x+thrust4.x,y+thrust4.y);


draw_self();