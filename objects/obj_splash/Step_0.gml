/// @description
if(layer_sequence_is_finished(sequence)){
    layer_sequence_destroy(sequence);
    layer_destroy(splash_layer);
    instance_destroy();
}