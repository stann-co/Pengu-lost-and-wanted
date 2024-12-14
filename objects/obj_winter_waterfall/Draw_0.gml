/// @description
draw_sprite_wavey(spr_winter_waterfall,0,x,y,image_xscale,image_yscale,image_angle,0.8,spd,xFrequency,xSize);

gpu_set_blendmode(bm_add)
draw_sprite_uv_move(spr_winter_waterfall,1,x,y,image_xscale,image_yscale,image_angle,1,uv_spd_x,uv_spd_y);
gpu_set_blendmode(bm_normal)

part_system_drawit(ps);