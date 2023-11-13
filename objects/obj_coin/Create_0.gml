/// @description
// Inherit the parent event
event_inherited();


trigger = function(){
	if(state.state_is("idle")){
		state.change("collect");
	}
}

sprite = spr_deco_bear;

y_offset_max = 2;
rot_offset_max = 10;
duration = game_speed * 1.2;


acceleration = 0.2;


state = new SnowState("idle");

state

.add("idle", {
	enter: function(){
			
	},
	
	step: function(){
		
	}
})

.add("collect", {
	enter: function(){
		
		
	},
	
	step: function(){
		
		x = lerp(x,obj_pengu.x,0.2);
		y = lerp(y,obj_pengu.y,0.2);
		if(point_distance(x,y,obj_pengu.x,obj_pengu.y) < 2){
			global.score++;
			instance_destroy();
		}
	}
	
})