#macro VERSION "0.1.5-alpha"

#macro IN_BROWSER (os_type != os_windows)

//Where all macros are set
#macro GAME_SPEED game_get_speed(gamespeed_fps)

#macro CAMERA_OUTER_MARGIN 200
#macro CAMERA_INNER_MARGIN 100

#macro MAIN_MENUS (room == rm_init)
#macro PAUSING     (obj_game.state.state_is("pause_menu") || obj_game.state.state_is("settings"))
#macro FREEZE_FRAME (global.freeze_duration != 0)
#macro CAN_MOVE_NOFREEZE (!PAUSING && !instance_exists(obj_level_editor)) 
#macro CAN_MOVE   (CAN_MOVE_NOFREEZE && !FREEZE_FRAME)


#macro ENTITY_COLLISION_LAYER [obj_collision,global.collision_layers[? collision_layer]]

#macro TEXT_HEIGHT 14

#macro SCALE_3D 32 //meter in blender = 32 pixels

//colors
#macro RED #ff0000
#macro ORANGE #ff9c00
#macro YELLOW #ffdd00
#macro GREEN #00ff04
#macro CYAN #22e7ff
#macro BLUE #0047ff
#macro PURPLE #a400ff
#macro PINK #ff14b9
#macro LIGHT_PINK #ff9ae2

#macro PENGU_BLUE #3978a8
#macro PENGU_WHITE #dff6f5

#macro WHITE c_white
#macro LIGHT_GRAY #BCBCBC
#macro GRAY c_gray
#macro DARK_GRAY #373737
#macro BLACK c_black

#macro NORMAL_BLANK #8080F9

//enums
enum COLLISION_LAYERS {
	A,
	B,
	C,
}

enum LANGUAGES {
	ENGLISH,
	//DANISH,
	//RUSSIAN,
	TOTAL
}

enum MENU_SETTINGS {
	FULLSCREEN,
	MUSIC_VOLUME,
	SOUND_VOLUME,
	DRAW_SHINE,
	DRAW_REFLECTIONS,
	DEBUG_DRAW,
    SHOW_COLLISIONS,
	TOTAL
}

enum SIDES {
	LEFT,
	RIGHT,
	TOP,
	BOTTOM,
}

enum ATTACK_TYPES {
    ATTACK,
    KICK,
	DUNK,
    JUMP,
    DASH,
    COLLIDE, //Like hitting walls ect
    SPEICAL
}

enum LAYER_TYPE {
    TILEMAP,
    ASSET,
    INSTANCE
}

#macro VOLUME_MAX 10
global.music_volume = 10;
global.sound_volume = 10;

global.draw_shine = true;
global.draw_reflections = true;

//globals
global.t = 0; //a global timer for different objects to refer to stay in sync even after being deactivated
global.t_always = 0; //global timer that keeps going even when there's a freeze frame

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

//Feather disable GM2017
global.persistent_objects = [
    obj_camera,
    __InputUpdateController,
    __obj_stanncam_manager,
    obj_scene,
    obj_game,
    obj_pengu, 
    obj_depth_set,
    obj_layer_draw,
    obj_splash
]
//Feather enable GM2017

global.sidescroller = true;

global.depth_a = 300;
global.depth_b = 400;
global.depth_c = 500;

global.collision_layers = ds_map_create()
global.collision_layers[? COLLISION_LAYERS.A] = undefined
global.collision_layers[? COLLISION_LAYERS.B] = undefined
global.collision_layers[? COLLISION_LAYERS.C] = undefined

global.room_data = {}; //externally loaded json room data, parralax layers

global.activation_list = [];

global.debug = false;
global.show_collisions = true;
global.show_background = false; //background layer Background_1 if off, it'll show the background drawing function set instead

global.checkpoint = -1;

global.score = 0;
global.score_mult = 1;
global.score_combo_t = 0;
#macro SCORE_COMBO_T_MAX (GAME_SPEED * 3)
global.coins = 0;

global.control = true;

//freeze frame is active when greater than 0, ticks down 1 each frame
global.freeze_duration = 0;

#region particles
global.part_stars = part_type_create();
part_type_sprite(global.part_stars,spr_hit_stars,false,false,true);
//part_type_shape(global.part_stars,pt_shape_star);
//part_type_colour_hsv(global.part_stars, 0, 255, 150, 150, 255, 255);
part_type_size(global.part_stars,0.4,0.45,-0.012,0);
part_type_direction(global.part_stars,0,360,0,10);
part_type_life(global.part_stars,60,60);
part_type_speed(global.part_stars,3,4,-0.18,0);
part_type_alpha3(global.part_stars,1,1,0);
//part_type_gravity(global.part_stars,0.05,270);
part_type_orientation(global.part_stars,0,360,2,1,false);
#endregion

//gui
global.gui_draw = true;

//fonts
global.gui_font = font_add_sprite_ext(spr_gui_font,"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]",false,0);

#region lexicon / languages
    lexicon_index_declare_from_json("local_en.json");
    lexicon_language_set("English");
#endregion

//spawns persistent objects

//room_instance_add(rm_init,0,0,obj_gmlive);
room_instance_add(rm_init,0,0,obj_camera);
room_instance_add(rm_init,0,0,obj_game);