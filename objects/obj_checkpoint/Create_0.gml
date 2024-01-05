/// @description 

trigger = function(){
	if(!active){
		active = true;
		save_checkpoint(x,y-10);
		state.change("activate");
	}
}

subimg = 0;
t = 0;
active = false;
activate_duration = game_speed*0.74;
scale_duration = game_speed*0.5;

scalex = 1;
scaley = 1;

state = new SnowState("idle");

state

.add("idle",{
	enter: function(){
		scalex = 1;
		scaley = 1;
		subimg = 0;	
	}
})

.add("activate", {
	enter: function(){
		subimg = 0;
		t = 0;
		
		particle_burst(ps_confetti,-40,0,45);
		particle_burst(ps_confetti,40,0,-45);
		
	},
	step: function(){
		if(t < activate_duration) t++;
		else state.change("idle");
		
		subimg = (t/(activate_duration/4));
		
		var scale_t = min(t,scale_duration);
		scalex = 1 + ( animcurve_read(ac_checkpoint,"scalex",scale_t/scale_duration) * 0.2);
		scaley = 1 + ( animcurve_read(ac_checkpoint,"scaley",scale_t/scale_duration) * 0.2);
		
	}
})







