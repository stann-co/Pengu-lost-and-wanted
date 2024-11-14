/// @description

event_inherited();

image_speed = 0;

//The main pole references the other pole
//the other pole shouldn't have any references

seat = noone;

wire_x_offset = 8;
bottom_wire_y_offset = -46;
top_wire_y_offset = -59;

if(other_pole != noone) {
	main_pole = true;
	
	point1 = new Vector2(x+wire_x_offset, y+bottom_wire_y_offset);
	
	point2 = new Vector2(other_pole.x+wire_x_offset, other_pole.y+bottom_wire_y_offset);
	
	point3 = new Vector2(other_pole.x+wire_x_offset, other_pole.y+top_wire_y_offset);
	
	point4 = new Vector2( x+wire_x_offset, y+top_wire_y_offset);
	
	other_pole.other_pole = self.id;
	
	activation_link(self,other_pole);
}
else {
	main_pole = false;
}