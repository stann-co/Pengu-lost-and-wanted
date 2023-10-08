/// @description

var val = animcurve_read(animcurve,0,t/duration);
t++;
if(t == duration) t = 0;

x = lerp(xstart,info_target.x,val);
y = lerp(ystart,info_target.y,val);