/// @description

event_inherited()

ps = part_system_create();
emitter = part_emitter_create(ps)
part_system_automatic_draw(ps, false);

part = particle_get_type(ps_spark);
part_emitter_relative(ps,emitter,true);

