function particle_get_type(particle_asset, emitter_index=0) {
    return particle_get_info(particle_asset).emitters[emitter_index].parttype.ind;
}