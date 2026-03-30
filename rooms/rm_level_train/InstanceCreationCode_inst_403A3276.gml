trigger = function(_inst){ 
	//activates collision switch
    inst_306FA046.active = true;
	
	//activate camera zones
	inst_415012DF.active = true;
	inst_E190D31.active = true;
	
	//activate enemy waves
	inst_116EDF4C.active = true;
	
	instance_destroy();
	
}