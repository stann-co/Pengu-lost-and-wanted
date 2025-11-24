/// @description
w_radius = 9;
h_radius = 20;

mass = 20;
drag = 0.01;

var points_ = []
array_push(points_,new Verlet(0,-4,mass,1));
array_push(points_,new Verlet(0,-15,mass,0));
array_push(points_,new Verlet(0,-29,mass,0));
array_push(points_,new Verlet(0,-44,mass,0));

spine = new VerletRodPoints(points_)

y_scale = 1;
y_origin = 1;
x_scale = 1;
x_origin = 1;

Inspectron()
	.Slider("y_scale",0,1)
    .Slider("y_origin",-1,1)
	.Slider("x_scale",0,1)
    .Slider("x_origin",-1,1)
	.render()


draw_sprite_entity = function(_sprite,_subimg,_x,_y,_xscale,_yscale,_rot,_color,_alpha){
    
    var y_offset_ = (y + (_y - y)*y_scale)+(h_radius*(1-y_scale)*y_origin);
    var x_offset_ = (x + (_x - x)*x_scale)+(w_radius*(1-x_scale)*x_origin);
    
    draw_sprite_ext(_sprite,_subimg,x_offset_,y_offset_,x_scale,y_scale,_rot,_color,_alpha);
}