/// @description

target_x = global.camera.get_mouse_x();
target_y = global.camera.get_mouse_y();

body.update(drag);
body.spring(target_x,target_y,stiffness);