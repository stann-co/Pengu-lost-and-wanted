/// @description

for(var i = 0; i < array_length(enemies);i++){
    
    
    if (!instance_exists(enemies[i])){
        array_delete(enemies,i,1);
        i--;
    }
}

if(array_length(enemies) == 0){
    spawn_enemies();
}

