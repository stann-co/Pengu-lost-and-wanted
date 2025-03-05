// Feather disable all

//This script contains the default profiles, and hence the default bindings and verbs, for your game
//
//  Please edit this macro to meet the needs of your game!
//
//The struct return by this script contains the names of each default profile.
//Default profiles then contain the names of verbs. Each verb should be given a binding that is
//appropriate for the profile. You can create bindings by calling one of the input_binding_*()
//functions, such as input_binding_key() for keyboard keys and input_binding_mouse() for
//mouse buttons

return {
    
    keyboard_and_mouse:
    {
        up:    [input_binding_key(vk_up),	 input_binding_key("W")],
        down:  [input_binding_key(vk_down),  input_binding_key("S")],
        left:  [input_binding_key(vk_left),  input_binding_key("A")],
        right: [input_binding_key(vk_right), input_binding_key("D")],
		
		jump: [input_binding_key(vk_space),input_binding_key("Z")],
		//attack: [input_binding_key(vk_control),input_binding_key("X")],
		dash: [input_binding_key(vk_shift),input_binding_key("X")],
		
		accept: [input_binding_key(vk_enter),input_binding_key("Z")],
		cancel: [input_binding_key("X")],
        
        pause: [input_binding_key(vk_tab),input_binding_key(vk_backspace)],
    },
    
    gamepad:
    {
        up:    [input_binding_gamepad_axis(gp_axislv, true),  input_binding_gamepad_button(gp_padu)],
        down:  [input_binding_gamepad_axis(gp_axislv, false), input_binding_gamepad_button(gp_padd)],
        left:  [input_binding_gamepad_axis(gp_axislh, true),  input_binding_gamepad_button(gp_padl)],
        right: [input_binding_gamepad_axis(gp_axislh, false), input_binding_gamepad_button(gp_padr)],
        
        jump:  [input_binding_gamepad_button(gp_face1)],
		//attack:  [input_binding_gamepad_button(gp_face3)],
        dash:  [input_binding_gamepad_button(gp_face2),input_binding_gamepad_button(gp_face3),input_binding_gamepad_button(gp_face4)],
		
		accept: [input_binding_gamepad_button(gp_face1),input_binding_gamepad_button(gp_face4)],
		cancel: [input_binding_gamepad_button(gp_face2),input_binding_gamepad_button(gp_face3)],
        
        pause: [input_binding_gamepad_button(gp_start),input_binding_gamepad_button(gp_select)],
    },    
};
