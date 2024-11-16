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
#macro light_gray #BCBCBC
#macro gray c_gray
#macro dark_gray #373737
#macro black c_black

#macro normal_blank #8080F9

//enums
enum COLLISION_LAYERS {
	A,
	B,
	C,
}

//globals
global.t = 0; //a global timer for different objects to refer to stay in sync even after being deactivated

//The angles from each collision tile
//360 is for filled blocks, which top angle could be any direction
global.tile_angles = [
  0,360, 22, 22, 45,360, 45, 22,
  7, 15, 30, 45, 83, 60, 45, 37,
 22, 37,  7,  7,  7, 15, 15, 15,
  7, 45, 83, 75, 53, 45, 22, 22,
 15, 15,  7,  7,  0,  0,  0,  0,
 45, 22,  7, 45, 15, 68, 75, 83,
 15, 45,  7, 22, 45, 30, 15, 15,
 30,
 
];

global.depth_a = 300;
global.depth_b = 400;
global.depth_c = 500;

global.activation_list = [];

global.debug = false;
global.checkpoint = -1;

global.score = 0;

//when a layer get's set to a obj_layer_draw, it's added to this with the layer name as the key
global.tile_draw_layers = ds_map_create()