/// @description
state.step();

while(array_length(queue) != 0 && !halt && CAN_MOVE){
    var func_ = array_shift(queue);
    func_();
}

