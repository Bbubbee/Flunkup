extends TileMap
class_name WorldTileMap

# Tile map info. 
var ground_layer: int = 0
var plant_layer: int = 1 
var source_id: int = 0

var dirt_atlas_coord : Vector2i = Vector2i(13, 7) # Vector2i(13, 7)
var plant_atlas_coord : Vector2i = Vector2i(21, 2) # Vector2i(13, 7)

# The base crop of which all Crop resources use. 
const BASE_CROP = preload("res://scenes/crops/base_crop.tscn")


var tileset_layer: int = 0

# Used in upper world script. 
@onready var hazards: Node2D = $Hazards

func _ready():
	Events.process_tile.connect(_on_process_tile)
	Events.plant_on_tile.connect(_on_plant_on_tile)


@onready var crops = $Crops

## Plant a crop on top of this tile. 
func _on_plant_on_tile(pos: Vector2, crop: Crop):
	# Get tile positions. 
	var tile_pos = local_to_map(pos)
	var tile_above_pos = Vector2i(tile_pos.x, tile_pos.y-1)
	var new_pos = map_to_local(tile_above_pos)
	
	# See if can plant on tile. 
	if retrieve_custom_data(tile_pos, "can_plant", ground_layer):
		# Spawn crop!!!
		var crop_scene = BASE_CROP.instantiate()
		crop_scene.position = new_pos
		crops.add_child(crop_scene)
		crop_scene.init(crop)
			

## Till this tile. 
func _on_process_tile(tile_pos: Vector2i): 
	if retrieve_custom_data(tile_pos, "can_till", 0): 
		set_cell(ground_layer, tile_pos, 0, dirt_atlas_coord)
	elif retrieve_custom_data(tile_pos, "can_water", 0): 	
		set_cell(ground_layer, tile_pos, 0, dirt_atlas_coord, 2)

## Gets a tile within the tilemap. 
## @param: layer = the layer of the tilemap. Defaults to 0, the ground layer. 
## If 
func get_valid_tile(pos: Vector2, custom_data_layer: String = "", layer: int = 0): 
	var tile_pos: Vector2i = local_to_map(pos)
	
	# Hacky way to seeing if there exists a tile in this pos.
	# May have to revamp later. 
	var tile_source = get_cell_source_id(layer, tile_pos) 
	if tile_source < 0: 
		return null
	
	# If you want to check if a custom data layer is true or exists, you can. 
	# Else, it will just return the tile pos. 
	if custom_data_layer: 
		if retrieve_custom_data(tile_pos, custom_data_layer, layer): return tile_pos
		else: return null 
	else: return tile_pos


func get_tile(pos: Vector2):
	return local_to_map(pos) 
		
	# Original tile.
	# Local position. 


## Checks if the selected tile contains the specified custom data.
## Returns true or false. 
## @param: tile_mouse_pos    = the position of the selected tile. 
## @param: custom_data_layer = checks if this tile has this custom data.
## @param: layer             = the layer the tile is on. I.e. ground, plants.
func retrieve_custom_data(tile_pos: Vector2i, custom_data_layer: String, layer: int):
	var tile_data: TileData = get_cell_tile_data(layer, tile_pos)
	if tile_data: return tile_data.get_custom_data(custom_data_layer)
	else: return false


var custom_data_layers = [
	'can_till',
	'can_plant',
	'can_water'
]

## return -> A tile a list of a tile  custom data. They can have multiple. 
func tiles_custom_data_list(tile_pos: Vector2i, layer: int) -> Array[String]: 
	var tile_data: TileData = get_cell_tile_data(layer, tile_pos)
	var tiles_custom_data: Array[String] = []

	for custom_data in custom_data_layers:
		if tile_data.get_custom_data(custom_data): 
			tiles_custom_data.append(custom_data)
	
	if tiles_custom_data:
		return tiles_custom_data
		
	return []


func act_upon(): 
	var selected_tile: Vector2i = last_selected_tile
	if not selected_tile: return
	
	var cd_list: Array[String] = tiles_custom_data_list(last_selected_tile, tileset_layer)
	if not cd_list: return
	
	# Either till or water the tile.
	if retrieve_custom_data(selected_tile, 'can_till', tileset_layer):
		set_cell(ground_layer, selected_tile, 0, dirt_atlas_coord)
	elif retrieve_custom_data(selected_tile, 'can_water', tileset_layer):
		set_cell(ground_layer, selected_tile, 0, dirt_atlas_coord, 2)
			
			
	
	
	
	# Get the custom data of the tile. 
	
	#if retrieve_custom_data(tile_pos, "can_till", 0): 
		#set_cell(ground_layer, tile_pos, 0, dirt_atlas_coord)
	#elif retrieve_custom_data(tile_pos, "can_water", 0): 	
		#set_cell(ground_layer, tile_pos, 0, dirt_atlas_coord, 2)

var last_selected_tile: Vector2

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('left_click'):
		var pos = get_global_mouse_position()
		
		# Check what tile is selected. 
		# Don't typecast because may be null. 
		var selected_tile = get_valid_tile(pos)
		if selected_tile:
			last_selected_tile = selected_tile
			var local_pos = map_to_local(Vector2i(selected_tile.x, selected_tile.y-1))
			Events.position_helipod.emit(local_pos, self)
		# Position to that tile. 
		
		
		

