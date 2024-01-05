//Where all macros are set
#macro game_speed game_get_speed(gamespeed_fps)

#macro camera_outer_margin 200
#macro camera_inner_margin 100

#macro can_move obj_game.state.state_is("idle")

#macro text_height 14

//colors
#macro red #ff0000
#macro orange #ff9c00
#macro yellow #ffdd00
#macro green #00ff04
#macro cyan #22e7ff
#macro blue #0047ff
#macro purple #a400ff
#macro pink #ff14b9

#macro pengu_blue #3978a8
#macro pengu_white #dff6f5

#macro white c_white
#macro gray c_gray
#macro black c_black



//globals
global.t = 0; //a global timer for different objects to refer to stay in sync even after being deactivated

//The angles from each collision tile
//360 is for filled blocks, which top angle could be any direction
global.tile_angles = [
0,360,22,22,45,
45,22,22,45,45,
31,12,12,31,45,
0 ,39,22,8 ,45,
45,8 ,22,39,45,22
];

global.depth_a = 300;
global.depth_b = 400;

global.activation_list = [];

global.debug = false;
global.checkpoint = -1;

global.score = 0;