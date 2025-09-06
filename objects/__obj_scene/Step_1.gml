/// @description
state.step();

while(array_length(queue) != 0 && !halt && can_move){
    var func = array_shift(queue);
    func();
}

