/// @description general base object, deals with which layer entity is on, and parent child relations

#region collision layer and depth
switch (depth_layer) {
	case "above A":
        collision_layer = COLLISION_LAYERS.A
		depth = DEPTH_A-100;
        break;
    case "A":
        collision_layer = COLLISION_LAYERS.A
		depth = DEPTH_A;
        break;
	case "B":
        collision_layer = COLLISION_LAYERS.B 
		depth = DEPTH_B;
        break;
	case "C":
        collision_layer = COLLISION_LAYERS.C
		depth = DEPTH_C;
        break;
	case "below C":
        collision_layer = COLLISION_LAYERS.C
		depth = DEPTH_C+100;
        break;
}
#endregion

#region Parent child relations

add_children = function(_array_entity){
	if (is_array(_array_entity)){
		for (var i_ = 0; i_ < array_length(_array_entity); i_++) {
			add_child(_array_entity[i_])
		}
	} else show_error($"{_array_entity} not array}",true)
}

add_child = function(_entity){
	if instance_exists(_entity){
		if(object_is_ancestor(_entity.object_index,obj_entity)){
			if (!array_contains(children,_entity)){
				array_push(children,_entity)
				_entity.parent = id
			} else show_error($"{_entity} already a child of {self}",id)
		} else show_error($"{_entity} not an entity}",true)
	} else show_error($"{_entity} doesn't exist'}",true)
}

remove_child = function(_entity){
	children = array_filter(children,function(el_,i_){
		return !array_contains(children,el_);
	})
	_entity.parent = noone;
}

set_parent = function(_entity){
	clear_parent();
	parent = _entity;
	parent.add_child(id);
}

clear_parent = function(){
	if(parent != noone){
		parent.remove_child(id);
	}
}

children = [] //children will move and rotate along with parent, if parent is moved with move functions

///@desc set x, and move all children accordingly
set_x = function(_val){
	var size_ = array_length(children);
	if (size_ > 0){
		var x_prev_ = x;
		var delta_ = _val - x_prev_;
		x = _val;
		for (var i_ = 0; i_ < array_length(children); i_++) {
			var child_ = children[i_];
			child_.set_x(child_.x+delta_);
		}
	} else {
		x = _val;
	}
}

///@desc set y, and move all children accordingly
set_y = function(_val){
	var size_ = array_length(children);
	if (size_ > 0){
		var y_prev_ = y;
		var delta_ = _val - y_prev_;
		y = _val;
		for (var i_ = 0; i_ < array_length(children); i_++) {
			var child_ = children[i_];
			child_.set_y(child_.y+delta_);
		}
	} else {
		y = _val;
	}
}

///@desc set image_angle, and move/rotate all children accordingly
set_angle = function(_angle){
	var size_ = array_length(children);
	if (size_ > 0){
		var angle_prev_ = image_angle;
		var delta_ = _angle - angle_prev_;
		image_angle = _angle;
		for (var i_ = 0; i_ < array_length(children); i_++) {
			var child_ = children[i_];
			var vec_ = new Vector2(child_.x-x,child_.y-y);
			vec_ = vec_.rotated(-delta_);
			child_.set_x(x+vec_.x);
			child_.set_y(y+vec_.y);
			child_.set_angle(child_.image_angle+delta_);
		}
	} else {
		image_angle = _angle;
	}
}

#endregion
