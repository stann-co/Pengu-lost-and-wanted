function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        UP,
        DOWN,
        LEFT,
        RIGHT,
        JUMP,
        ATTACK,
        DASH,
        INTERACT,
        ACCEPT,
        CANCEL,
        PAUSE,
        OPTION,
    }
    
    InputDefineVerb(INPUT_VERB.UP,       "up",       [vk_up    ,"W"],  [-gp_axislv,gp_padu]);
    InputDefineVerb(INPUT_VERB.DOWN,     "down",     [vk_down  ,"S"],  [ gp_axislv,gp_padd]);
    InputDefineVerb(INPUT_VERB.LEFT,     "left",     [vk_left  ,"A"],  [-gp_axislh,gp_padl]);
    InputDefineVerb(INPUT_VERB.RIGHT,    "right",    [vk_right ,"D"],  [ gp_axislh,gp_padr]);
    
    InputDefineVerb(INPUT_VERB.JUMP,     "jump",     [vk_space  ,"Z"], [ gp_face1]);
    InputDefineVerb(INPUT_VERB.ATTACK,   "attack",   [vk_control,"X"], [ gp_face3]);
    InputDefineVerb(INPUT_VERB.DASH,     "dash",     [vk_shift,"C"],   [ gp_face2]);
    InputDefineVerb(INPUT_VERB.INTERACT, "interact", ["E","V"],        [ gp_face4]);
    
    InputDefineVerb(INPUT_VERB.ACCEPT,   "accept",   [vk_enter, "Z"],  [ gp_face1,gp_face4]);
    InputDefineVerb(INPUT_VERB.CANCEL,   "cancel",   [vk_escape,"X"],  [ gp_face2,gp_face3]);
      
    InputDefineVerb(INPUT_VERB.PAUSE,    "pause",    [vk_escape],      [gp_start]);
    InputDefineVerb(INPUT_VERB.OPTION,   "option",   [vk_tab],         [gp_select]);
}
