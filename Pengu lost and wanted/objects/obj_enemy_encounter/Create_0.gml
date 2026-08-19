/// @description


enemies = []

spawn_enemies = function(){
    var enemy_ = instance_create_layer(x-80,y,"instances",obj_test_dummy);
    array_push(enemies,enemy_);
    
    enemy_ = instance_create_layer(x+80,y,"instances",obj_test_dummy);
    array_push(enemies,enemy_);
}

spawn_enemies();