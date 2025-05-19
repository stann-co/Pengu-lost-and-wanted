/// feather ignore all in /Extensions/*

#macro version "0.1.2-alpha"

#macro in_browser (os_type != os_windows)

//Where all macros are set
#macro game_speed game_get_speed(gamespeed_fps)

#macro camera_outer_margin 200
#macro camera_inner_margin 100

#macro main_menus (room == rm_init)
#macro can_move (!obj_game.state.state_is("pause_menu") && !obj_game.state.state_is("settings") && !global.freeze_frame)

#macro text_height 14

//#macro gamepad gamey_pad

//colors
#macro red #ff0000
#macro orange #ff9c00
#macro yellow #ffdd00
#macro green #00ff04
#macro cyan #22e7ff
#macro blue #0047ff
#macro purple #a400ff
#macro pink #ff14b9
#macro light_pink #ff9ae2

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

enum LANGUAGES {
	English,
	//Danish,
	//Russian,
	TOTAL
}

enum MENU_SETTINGS {
	fullscreen,
	music_volume,
	sound_volume,
	draw_shine,
	draw_reflections,
	debug_draw,
	TOTAL
}

enum SIDES {
	Left,
	Right,
	Top,
	Bottom,
}

#macro volume_max 10
global.music_volume = 10;
global.sound_volume = 10;

global.draw_shine = true;
global.draw_reflections = true;

//globals
global.t = 0; //a global timer for different objects to refer to stay in sync even after being deactivated

//The angles from each collision tile
//360 is for filled blocks, which top angle could be any direction
global.tile_angles = [
  0,360,  0,  0,  0,  0,  0, 22, 22,
 22,  7, 15, 15,  7, 45, 45, 15, 30,
 30, 15, 45, 15, 45, 22,  7, 37, 22,
  7, 45, 30, 15,  7, 45, 37, 30, 15,
  7, 60, 52, 67, 67, 75, 82,  7, 45,
  7, 22, 45, 45,  7, 15, 30, 45,  7,
 15, 30, 82, 67, 52, 45, 30, 37,  7,
  7, 15, 22,
 
];

global.sidescroller = true;

global.depth_a = 300;
global.depth_b = 400;
global.depth_c = 500;

global.activation_list = [];

global.debug = false;
global.checkpoint = -1;

global.score = 0;
global.score_mult = 1;
global.score_combo_t = 0;
#macro score_combo_t_max (game_speed * 3)
global.coins = 0;

global.freeze_frame = false;

//when a layer get's set to a obj_layer_draw, it's added to this with the layer name as the key
global.tile_draw_layers = ds_map_create()

//particles
global.part_stars = part_type_create();
part_type_shape(global.part_stars,pt_shape_star);
part_type_colour_hsv(global.part_stars, 0, 0, 0, 0, 255, 255);
part_type_size(global.part_stars,0.4,0.4,-0.03,0);
part_type_direction(global.part_stars,0,360,0,10);
part_type_life(global.part_stars,20,30);
part_type_speed(global.part_stars,2,2,0,2);
part_type_alpha3(global.part_stars,1,1,0);

//fonts
global.gui_font = font_add_sprite_ext(spr_gui_font,"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]",false,0);

function level_details(name_,room_) constructor {
	name = name_
	room_id = room_
	level_score = 0
	level_time = undefined
	checkpoint = undefined
	checkpoint_score = 0
	checkpoint_coins = 0
	checkpoint_timer = 0
}

global.active_level = undefined;

global.levels = [
	new level_details("TUTORIAL",rm_demo_tutorial),
	new level_details("DEMO",rm_demo_demo),
	new level_details("CHALLENGE",rm_demo_challenge)
]

//3D
#macro BBMOD_MATERIAL_DEFAULT -1

//spawns persistent objects

room_instance_add(rm_init,0,0,obj_camera)
room_instance_add(rm_init,0,0,obj_game)