function save_checkpoint(x,y){	
	global.checkpoint = {
		x: x,
		y: y,
		taken_points: obj_game.taken_points,
		time: global.t,
	}
}