/// @description

global.camera.follow = self;

#region variables

hspd = 0;
vspd = 0;


ground_spd = 0; //how fast it's moving on the ground
ground_angle = 0; //the grounds angle

w_radius = 8; //width radius
h_radius = 8; //height radius

grav = 0.1;

grounded = false;

#endregion

#region sensors

vec_r = new Vector2(0,0); //right
vec_l = new Vector2(0,0); //left

vec_b = new Vector2(0,0); //bottom
vec_t = new Vector2(0,0); //top

vec_bl = new Vector2(0,0); //bottom left
vec_br = new Vector2(0,0); //bottom right

vec_tl = new Vector2(0,0); //top left
vec_tr = new Vector2(0,0); //top right

bl_collide = function(){
	return collision_point(x+vec_bl.x,y+vec_bl.y,[global.collision_tiles],true,true);	
}
br_collide = function(){
	return collision_point(x+vec_br.x,y+vec_br.y,[global.collision_tiles],true,true);	
}
tl_collide = function(){
	return collision_point(x+vec_tl.x,y+vec_tl.y,[global.collision_tiles],true,true);	
}
tr_collide = function(){
	return collision_point(x+vec_tr.x,y+vec_tr.y,[global.collision_tiles],true,true);
}

#endregion