/// @description

draw_grid();

new BBMOD_Matrix()
	.Scale(1, 1, 1)
	.Translate(0, 0, 0)
	.ApplyWorld();
animplayer.submit();
new BBMOD_Matrix().ApplyWorld();

shader_reset();

cm_spatialhash_debug_draw(global.colmesh)

cm_box_debug_draw(player.shape);
