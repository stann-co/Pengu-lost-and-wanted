/// @description sets depth
switch (depth_layer) {
	case "above A":
        depth = global.depth_a-50;
        break;
    case "A":
        depth = global.depth_a+10;
        break;
	case "B":
        depth = global.depth_b+10;
        break;
	case "C":
        depth = global.depth_c+10;
        break;
}

