/// @desc  plays sequence on gui
/// @param {Sequence*} _sequence_element Description
function splash_sequence(_sequence_element){
    
    instance_create_depth(0,0,0,obj_splash,{
        sequence_element: _sequence_element
    });

}