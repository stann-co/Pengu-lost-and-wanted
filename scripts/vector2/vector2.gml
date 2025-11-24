/// Mostly ported from: https://github.com/godotengine/godot/blob/master/core/math/_vector2.cpp
function Vector2(_x, _y) constructor {
	x = _x;
	y = _y;
	
	/// @func abs()
	/// @desc Returns a new vector with all components in absolute values.
	static absv = function() {
		return (new Vector2(abs(x), abs(y)));
	}
	
	/// @func angle()
	/// @param {bool} _return_radians
	/// @desc Returns this vector's angle with respect to the X axis.
	static angle = function(_return_radians) {
		return (_return_radians) ? arctan2(y, x) : darctan2(y, x);
	}	
	
	/// @func add()
	/// @param _vector2
	/// @desc Returns _vector2 added with the second _vector2
	static add = function(_vector2) {
		return new Vector2(x+_vector2.x,y+_vector2.y);
	}
	
	/// @func subtract()
	/// @param _vector2
	/// @desc Returns _vector2 subtracted by the second _vector2
	static subtract = function(_vector2) {
		return new Vector2(x-_vector2.x,y-_vector2.y);
	}
	
	
	/// @func length()
	/// @desc Returns the length (magnitude) of this vector.
	static length = function() {
		return sqrt(x * x + y * y);
	}
	
	/// @func length_squared()
	/// @desc Returns the squared length (squared magnitude) of this vector. Faster than length().
	static length_squared = function() {
		return (x * x + y * y);
	}
	
	/// @func normalize()
	/// @desc Normalizes the vector's components to be between 0 and 1.
	static normalize = function() {
		var l_ = length_squared();
		if (l_ != 0) {
			l_ = sqrt(l_);
			x = x / l_;
			y = y / l_;
		}
	}
	
	/// @func normalized()
	/// @desc Returns the vector scaled to unit length.
	static normalized = function() {
		var vector_ = self;
		vector_.normalize();
		return vector_;
	}
	
	/// @func is_normalized()
	/// @desc Returns true if the vector is normalized, and false otherwise.
	static is_normalized = function() {
		var epsilon_ = 0.0001;
		var difference_ = abs(length_squared() - 1.0);
		return (difference_ < epsilon_);
	}
	
	/// @func distance_to()
	/// @param _vector2
	/// @desc Returns the distance between the two vectors.
	static distance_to = function(_vector2) {
		//var check_ = instanceof(_vector2);
		//if (is_string(check_)) {
			return sqrt((x - _vector2.x) * (x - _vector2.x) + (y - _vector2.y) * (y - _vector2.y));
		//} else {
		//	return undefined;
		//}
	}
	
	/// @func distance_to_squared()
	/// @param _vector2
	/// @desc Returns the squared distance between the two vectors. Faster than distance_to().
	static distance_to_squared = function(_vector2) {
		var check_ = instanceof(_vector2);
		if (is_string(check_)) {
			return ((x - _vector2.x) * (x - _vector2.x) + (y - _vector2.y) * (y - _vector2.y));
		} else {
			return undefined;
		}
	}
	
	/// @func angle_to()
	/// @param _vector2
	/// @param {bool} return_radians
	/// @desc Returns the angle to the given vector.
	static angle_to = function(_vector2, _radians) {
		var check_ = instanceof(_vector2);
		if (is_string(check_)) {
			return (_radians) ? arctan2(cross(_vector2), dot(_vector2)) : darctan2(cross(_vector2), dot(_vector2));
		} else {
			return undefined;
		}
	}
	
	/// @func angle_to_point()
	/// @param _vector2
	/// @param {bool} return_radians
	/// @desc Returns the angle between the line connecting the two points and the X axis.
	static angle_to_point = function(_vector2, _radians) {
		var check_ = instanceof(_vector2);
		if (is_string(check_)) {
			return (_radians) ? arctan2(y - _vector2.y, x - _vector2.x) : darctan2(y - _vector2.y, x - _vector2.x);
		} else {
			return undefined;
		}
	}
	
	/// func dot()
	/// @param _vector2
	/// @desc Returns the dot product.
	static dot = function(_vector2) {
		return (x * _vector2.x + y * _vector2.y);
	}
	
	/// @func cross()
	/// @param _vector2
	/// @desc Returns the cross product.
	static cross = function(_vector2) {
		return (x * _vector2.x - y * _vector2.y);
	}
	
	/// @func sign()
	/// @desc Returns the vector with each component set to one or negative one, depending on the signs of the components, or zero if the component is zero.
	static signv = function() {
		return (new Vector2(sign(x), sign(y)));
	}
	
	/// @func floor()
	/// @desc Returns the vector with all components rounded down.
	static floorv = function() {
		return (new Vector2(floor(x), floor(y)));
	}
	
	/// @func ceil()
	/// @desc Returns the vector with all components rounded up.
	static ceilv = function() {
		return (new Vector2(ceil(x), ceil(x)));
	}
	
	/// @func round()
	/// @desc Returns the vector with all components rounded.
	static roundv = function() {
		return (new Vector2(round(x), round(y)));
	}
	
	/// @func rotated()
	/// @param _by_amount
	/// @desc Returns the vector rotated by the amount supplied in degrees or _radians.
	static rotated = function(_by_amount, _radians = false) {
		var sine_ = dsin(_by_amount); // 90 1
		var cosi_ = dcos(_by_amount); // 90 0
		return (new Vector2(x * cosi_ - y * sine_, x * sine_ + y * cosi_));
	}
	
	/// @func project()
	/// @param _vector2
	/// @desc Returns the vector projected onto the given vector.
	static project = function(_vector2) {
		return (_vector2 * (dot(_vector2) / _vector2.length_squared()));
	}
	
	/// @func snapped()
	/// @param _vector2
	/// @desc Returns this vector with each component snapped to the nearest multiple of step.
	static snapped = function(_vector2) {
		return new Vector2(floor(x / _vector2.x + 0.5) * _vector2.x, floor(y / _vector2.y + 0.5) * _vector2.y);
	}
	
	/// @func clamped()
	/// @param _max_length
	/// @desc Returns the vector with a maximum length by limiting its length to length.
	static clamped = function(_max_length) {
		var length_ = length();
		var vector_ = self;
		if (length_ > 0 and _max_length < length_) {
			vector_.x /= length_;
			vector_.y /= length_;
			vector_.x *= _max_length;
			vector_.y *= _max_length;
		}
		
		return vector_;
	}
	
	/// @func move_toward()
	/// @param _vector2
	/// @param _delta
	/// @desc Moves the vector toward _vector2 by the fixed _delta amount.
	static move_toward = function(_vector2, _delta) {
		var vector_ = self;
		var epsilon_ = 0.0001;
		var vector_delta_ = new Vector2(_vector2.x - vector_.x, _vector2.y - vector_.y);
		var length_ = vector_delta_.length();
		
		if (length_ <= _delta or length_ < epsilon_) {
			return new Vector2(_vector2.x,_vector2.y);
		} else {
			return new Vector2(vector_.x + vector_delta_.x / length_ * _delta, vector_.y + vector_delta_.y / length_ * _delta);
		}
	}
	
	/// @func is_approx_equal()
	/// @param _vector2
	/// @desc Returns true if this vector and v are approximately equal.
	static is_approx_equal = function(_vector2) {
		var epsilon_ = 0.0001;
		var x_difference_= abs(x - _vector2.x);
		var y_difference_ = abs(y - _vector2.y);
		return (x_difference_ < epsilon_ and y_difference_ < epsilon_);
	}
	
	static to_string = function() {
		return ("{" + string(x) + ", " + string(y) + "}");
	}
}