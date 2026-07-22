var fullscreen = !window_get_fullscreen();
if(fullscreen){
    stanncam_set_fullscreen();
}
else stanncam_set_windowed();