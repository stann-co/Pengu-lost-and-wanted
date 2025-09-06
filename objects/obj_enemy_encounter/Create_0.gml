/// @description


enemies = []

spawn_enemies = function(){
    var enemy = instance_create_layer(x-80,y,"instances",obj_test_dummy);
    array_push(enemies,enemy);
    
    enemy = instance_create_layer(x+80,y,"instances",obj_test_dummy);
    array_push(enemies,enemy);
}

spawn_enemies();