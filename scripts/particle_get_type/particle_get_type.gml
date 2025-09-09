function particle_get_type(_particle_asset, _emitter_index=0) {
    return particle_get_info(_particle_asset).emitters[_emitter_index].parttype.ind;
}