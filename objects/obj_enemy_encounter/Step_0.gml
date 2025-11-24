/// @description

for(var i_ = 0; i_ < array_length(enemies);i_++){
    
    
    if (!instance_exists(enemies[i_])){
        array_delete(enemies,i_,1);
        i_--;
    }
}

if(array_length(enemies) == 0){
    spawn_enemies();
}

