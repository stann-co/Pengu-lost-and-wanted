/// @desc Gets nested struct or undefined
/// @param {struct} _struct 
/// @param {any} _chain ...
function struct_get_chained(_struct) {
    if argument_count < 2 { throw "Missing parameters" }

    if !is_struct(_struct) return undefined;
    var current_ = _struct
    for(var i_ = 1; i_ < argument_count; i_++) {
        if (current_ == undefined) return undefined;
        current_ = current_[$ argument[i_]]
    }
    return current_
}

/**
 * @desc Sets nested struct to value, returns true or false if succesful or not
 * @param {struct} _struct
 * @param {any*} _value value to set
 * @param {any} _chain ...
 * @returns {bool} successful
 */
function struct_set_chained(_struct, _value) {
    if argument_count < 3 { throw "Missing parameters" }

    if !is_struct(_struct) return false;
    var current_ = _struct
    for(var i_ = 2; i_ < argument_count - 1; i_++) {
        current_[$ argument[i_]] ??= {}
        current_ = current_[$ argument[i_]]
    }
    current_[$ argument[argument_count - 1]] = _value
    return true
}