/// @description

x = 0;
y =  0;


ball1 = new Verlet(x-50,y);
ball2 = new Verlet(x+50,y);

grav = 9.8 / 100;



global.camera.move(0,0,0);
global.camera.room_constrain = false;
