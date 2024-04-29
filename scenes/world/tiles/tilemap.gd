extends TileMap


var dirt_atlas_coord : Vector2i = Vector2i(13, 7) # Vector2i(13, 7)
var plant_atlas_coord : Vector2i = Vector2i(21, 2) # Vector2i(13, 7)

var tileset_layer: int = 0


func _ready():
	Events.process_tile.connect(_on_process_tile)
	Events.plant_on_tile.connect(_on_plant_on_tile)


## Plant a crop on top of this tile. 
func _on_plant_on_tile(pos: Vector2):
	
	# Get tile positions. 
	var tile_pos = local_to_map(pos)
	var tile_above_pos = Vector2i(tile_pos.x, tile_pos.y-1)
	
	# See if can plant on tile. 
	if retrieve_custom_data(tile_pos, "can_plant", 1):
		# Check if the tile above is occupied. 
		var tile_data: TileData = get_cell_tile_data(1, tile_above_pos)
		
		# If it's not occupied, plant there!
		if not tile_data: set_cell(1, tile_above_pos, 0, plant_atlas_coord)
		

## Till this crop. 
func _on_process_tile(tile_pos: Vector2i): 
	if retrieve_custom_data(tile_pos, "can_till", 0): 
		set_cell(1, tile_pos, 0, dirt_atlas_coord)


func _input(event):
	if event.is_action_pressed('left_click'): 
		# Get the tile the mouse selected. 
		var mouse_pos = get_global_mouse_position()
		var tile_mouse_pos: Vector2i = local_to_map(mouse_pos)

		# Moves the helipod one tile above the selected tile.
		# Checks if the tile can be tilled first. 
		if retrieve_custom_data(tile_mouse_pos, "can_till", tileset_layer):
			# Position helipod one tile above selected tile. 
			var new_tile_pos = Vector2i(tile_mouse_pos.x, tile_mouse_pos.y-2)
			Events.position_helipod.emit(map_to_local(new_tile_pos), tile_mouse_pos)

			
## Checks if the selected tile contains the specified custom data.
## Returns true or false. 
## @param: tile_mouse_pos    = the position of the selected tile. 
## @param: custom_data_layer = checks if this tile has this custom data.
## @param: layer             = the custom data layer. IDK why you have to specify the layer and name
func retrieve_custom_data(tile_mouse_pos: Vector2i, custom_data_layer: String, layer: int) -> bool:
	var tile_data: TileData = get_cell_tile_data(layer, tile_mouse_pos)
	if tile_data: return tile_data.get_custom_data(custom_data_layer)
	else: return false


func check_if_cell_is_occupied(): 
	pass
