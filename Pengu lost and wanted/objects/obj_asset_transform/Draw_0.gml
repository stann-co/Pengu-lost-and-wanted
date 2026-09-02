/// @description draws its own sprite, plus a selection box when active

//offset-only parallax - unlike obj_tilemap, the sprite itself doesn't get
//scaled, just shifted away from screen center by the same amount obj_tilemap's
//view-matrix scale would move a point at this position
var p_ = parralax_offset(x, y, parralax_effective(parralax_x), parralax_effective(parralax_y));
px = p_.x;
py = p_.y;

editor_draw();

