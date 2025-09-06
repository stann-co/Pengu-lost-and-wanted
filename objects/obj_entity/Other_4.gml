/// @description initial collision layer

// Inherit the parent event
event_inherited();

/// @description sets initial collision layer
switch (depth_layer) {
	case "above A":
        collision_layer = COLLISION_LAYERS.A
        break;
    case "A":
        collision_layer = COLLISION_LAYERS.A
        break;
	case "B":
        collision_layer = COLLISION_LAYERS.B 
        break;
	case "C":
        collision_layer = COLLISION_LAYERS.C
        break;
	case "below C":
        collision_layer = COLLISION_LAYERS.C
        break;
}

