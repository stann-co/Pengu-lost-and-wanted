/// @description destroys particle system and instance
if (part_particles_count(ps) == 0)
{
    part_system_destroy(ps);
    instance_destroy();
}