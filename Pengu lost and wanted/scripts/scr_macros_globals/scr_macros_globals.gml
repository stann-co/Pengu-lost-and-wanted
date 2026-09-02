#macro VERSION "0.1.5-alpha"

#macro START_POINT "main menu"

#macro IN_BROWSER (os_type != os_windows)

//Where all macros are set
#macro SECOND game_get_speed(gamespeed_fps)
#macro TIMESTEP (delta_time * SECOND / 1_000_000)

#macro CAMERA_OUTER_MARGIN 200
#macro CAMERA_INNER_MARGIN 100

#macro MAIN_MENUS (room == rm_game)
#macro PAUSING     (obj_game.state.state_is("pause_menu") || obj_game.state.state_is("settings"))
#macro FREEZE_FRAME (global.freeze_duration != 0)
#macro CAN_MOVE_NOFREEZE (!PAUSING && !instance_exists(obj_level_editor)) 
#macro CAN_MOVE   (CAN_MOVE_NOFREEZE && !FREEZE_FRAME)

#macro TEXT_HEIGHT 14

#macro SCALE_3D 32 //meter in blender = 32 pixels
#macro TILE_SIZE 16 //base tile size is 16 pixels

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
#macro DARKER_GRAY #272727
#macro BLACK c_black

#macro NORMAL_BLANK #8080F9

//enums

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
    INSTANCE,
    BACKGROUND
}
global.LAYER_TYPES = ["Tilemap","Assets","Instances","Background"]; //index matches LAYER_TYPE enum value

enum BACKGROUND_MODE {
    NONE,
    TILED,
    FILL
}
global.BACKGROUND_MODES = ["None","Tiled","Fill"]; //index matches BACKGROUND_MODE enum value

//premade per-layer post-fx - index matches a layer's own fx_index. Each
//entry's setup/clear (see layer_fx_functions.gml) fully own their runtime
//state; params only lists the sliders shown in the Inspector and their defaults
global.LAYER_FX = [
	{ name: "None", setup: undefined, clear: undefined, params: [] },
	{ name: "Color Tint", setup: fx_setup_color, clear: fx_clear_color, params: [
		{name:"Red", min:0, max:1, default_value:1},
		{name:"Green", min:0, max:1, default_value:1},
		{name:"Blue", min:0, max:1, default_value:1},
		{name:"Intensity", min:0, max:1, default_value:0.5},
	]},
	{ name: "Blur", setup: fx_setup_blur, clear: fx_clear_blur, params: [
		{name:"Radius", min:0, max:32, default_value:6},
	]},
];

//one entry per layer currently running an fx: {layer_id, fx_index, params}.
//applying "None" (or removing the layer) deletes the entry again
global.layer_fx_list = ds_list_create();

#macro VOLUME_MAX 10
global.music_volume = 10;
global.sound_volume = 10;

global.draw_shine = true;
global.draw_reflections = true;

global.level = undefined

//globals
global.t = 0; //a global timer for different objects to refer to stay in sync even after being deactivated
global.t_always = 0; //global timer that keeps going even when there's a freeze frame

global.parralax = 1; //parralax scale, from 0-2 (0 off, 1 default, 2 doubled)

//The angles from each collision tile
//360 is for filled blocks, which top angle could be any direction
global.tile_angles = [
  360,360,  0,  0,  0,  0,  0, 22, 22,
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
	obj_stanncam_zone,
    obj_scene,
    obj_game,
    obj_pengu, 
    obj_tilemap,
    obj_splash,
	obj_background
]
//Feather enable GM2017

global.sidescroller = true;

#region collision and depth layers
enum COLLISION_LAYERS {
	A,
	B,
	C,
	None,
}

//TODO consider just using simple array instead of ds_map?
global.depths = ds_map_create();
global.depths[? COLLISION_LAYERS.A] = 10;
global.depths[? COLLISION_LAYERS.B] = 20;
global.depths[? COLLISION_LAYERS.C] = 30;

#macro DEPTH_A global.depths[? COLLISION_LAYERS.A]
#macro DEPTH_B global.depths[? COLLISION_LAYERS.B]
#macro DEPTH_C global.depths[? COLLISION_LAYERS.C]

global.collision_layers = ds_map_create()
global.collision_layers[? COLLISION_LAYERS.A] = undefined
global.collision_layers[? COLLISION_LAYERS.B] = undefined
global.collision_layers[? COLLISION_LAYERS.C] = undefined

//if this instance's collision layer is the same as the controlled collision_layer
#macro ACTIVE_COLLISION (collision_layer == global.controlled.collision_layer)

#macro ENTITY_COLLISION_LAYER [obj_collision,layer_tilemap_get_id(global.collision_layers[? collision_layer])]

#macro ACTIVE_PLAYER_COLLISION_LAYER (global.controlled != noone ? global.controlled.collision_layer : -1)
#macro CONTROLLED (global.controlled == self && global.in_control)

#endregion

global.level_step = function (){} //will run every step, override in each level, to have level specific step code happen

global.activation_list = [];

global.debug = false;
global.show_collisions = true;
global.show_background = false; //background layer Background_1 if off, it'll show the background drawing function set instead

global.checkpoint = -1;

global.score = 0;
global.score_mult = 1;
global.score_combo_t = 0;
#macro SCORE_COMBO_T_MAX (SECOND * 3)
global.coins = 20;

#region control
global.in_control = true; //wether the player has control or not, disable in cutscenes
global.controlled = noone; //the object/instance that the player controls, switch to and from vehicles, or other chars

//@desc set global.controlled to the active instance, or specific instance
function set_controlled(_inst = self){
	global.controlled = _inst;
}

#endregion

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
global.gui_font = font_add_sprite_ext(spr_gui_font,"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxz",false,0);

#region lexicon / languages
    lexicon_index_declare_from_json("local_en.json");
    lexicon_language_set("English");
#endregion

//GPU/Texture settings
gpu_set_tex_max_mip(5);
gpu_set_tex_mip_bias(-1);
gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_inv_src_alpha)
//gpu_set_ztestenable(true);

//ImGui
ImGui.__Initialize();
ImGui.ConfigFlagToggle(ImGuiConfigFlags.DockingEnable);

//room_instance_add(rm_game,0,0,obj_gmlive);
room_instance_add(rm_game,0,0,obj_camera);
room_instance_add(rm_game,0,0,obj_game);

//catspeak
//TODO: maybe do safer expose later, and or ban specific function calls, if not careful could be bad
Catspeak.interface.exposeEverythingIDontCareIfModdersCanEditUsersSaveFilesJustLetMeDoThis = true;