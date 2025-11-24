/// @description
ps = part_system_create();
emitter = part_emitter_create(ps)
part_system_automatic_draw(ps, false);

var part_ = particle_get_type(ps_rain);
part_emitter_stream(ps,emitter,part_,1);
