extends Node2D

@onready var tile_map: TileMap = $TempTilemap


func _input(event):
	if event.is_action_pressed('left_click'): 
		# Get the tile the mouse selected. 
		var mouse_pos = get_global_mouse_position()
		var tile_mouse_pos: Vector2i = tile_map.local_to_map(mouse_pos)
		
		# The atlas coord of the dirt tile in the tileset. 
		#var dirt_atlas_coord : Vector2i = Vector2i(13, 7)
		
		# Try and till the selected tile. 
		if retrieve_custom_data(tile_mouse_pos, "can_till", 0):
			# Position helipod one tile above selected tile. 
			var new_tile_pos = Vector2i(tile_mouse_pos.x, tile_mouse_pos.y-2)
			Events.position_helipod.emit(tile_map.map_to_local(new_tile_pos))
			
			# Till the tile!
			#tile_map.set_cell(0, tile_mouse_pos, 0, dirt_atlas_coord)

			


## Checks if the selected tile contains the specified custom data.
## Returns true or false. 
## @param: tile_mouse_pos    = the position of the selected tile. 
## @param: custom_data_layer = checks if this tile has this custom data.
## @param: layer             = the tileset layer to check. 
func retrieve_custom_data(tile_mouse_pos: Vector2i, custom_data_layer: String, layer: int) -> bool:
	var tile_data: TileData = tile_map.get_cell_tile_data(layer, tile_mouse_pos)
	if tile_data: return tile_data.get_custom_data(custom_data_layer)
	else: return false
