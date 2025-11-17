/// @description adds decor and asset layers

layers = [];

// tiles
var layers_ =  layer_get_all();
for (var i_ = 0; i_ < array_length(layers_); ++i_) {
	var lay_id_ = layers_[i_];
	var name_ = layer_get_name(lay_id_);
	
	var layer_ = {};
	layer_.id = lay_id_;
	layer_.depth = layer_get_depth(lay_id_);
	
	if(string_starts_with(name_,"decor")){
        layer_.type = LAYER_TYPE.DECOR
		layer_.name = name_;
		layer_.tilemap = layer_tilemap_get_id(lay_id_);
		
        array_push(layers,layer_);
		layer_set_visible(lay_id_,false);
    } else
    
    if(string_starts_with(name_,"asset")){
        layer_.type = LAYER_TYPE.ASSET
		layer_.name = name_;
		
        array_push(layers,layer_);
		layer_set_visible(lay_id_,false);
    }
}
