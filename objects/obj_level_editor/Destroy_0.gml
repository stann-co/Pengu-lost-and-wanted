/// @description
instance_destroy(obj_asset_transform) //removes all asset transforms

window_set_cursor(cr_default);
cursor_sprite = -1;
ImGui.EndFrame();

sync_imgui_layout_backup();

if (ds_exists(tileset_tiles, ds_type_grid)) ds_grid_destroy(tileset_tiles);
if (surface_exists(tileset_surface)) surface_free(tileset_surface);

if (smf != undefined) smf.destroy();
if (surface_exists(smf_preview_surface)) surface_free(smf_preview_surface);

surface_free(tileset_surface);
surface_free(tilebrush_surface);