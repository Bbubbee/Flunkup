extends Level
class_name WildLevels

@onready var tilemap: TileMap = $TempTilemap

# Boundaries of the world. 
var world_width: int = 60
var world_height: int = 90

# Player. 
@onready var player_camera: Camera2D = $PlayerCamera
@onready var player: Player = $Player
@onready var helipod: CharacterBody2D = $Helipod

# Noise to generate island placement. 
@export var noise_texture : NoiseTexture2D
var noise: Noise
var noise_val_arr = []

# Detects the player and transitions. 
@onready var player_detector_top: Area2D = $PlayerDetectorTop
@onready var player_detector_bot: Area2D = $PlayerDetectorBot


## Initialise children if have enter paramaters. 
func init(enter_params: EnterParams = null):
	if enter_params: 
		player.init(enter_params.player_state, enter_params.player_pos)
		helipod.init(enter_params.player_state)
	

func _ready() -> void:
	# Get the noise that we set in the editor. 
	noise = noise_texture.noise
	
	generate_world()
	spawn_spikes()
	setup_boundaries()
	
	# Generic initialisation, not dictated by enter parameters. 
	player_detector_top.init(boundaries, Vector2i.UP)
	player_detector_bot.init(boundaries, Vector2i.DOWN)
	player_camera.init(boundaries) 
	

# The world is a box. 
# The boundaries dictate things like player detectors, camera, spawns etc.	
var boundaries = {}
func setup_boundaries(): 
	var world_offset = 5*16
	var island_offset = 23*16 
	
	boundaries['left'] = 0 - (world_width*16)/2 - world_offset
	boundaries['right'] = 0 + (world_width*16)/2 + world_offset + island_offset
	boundaries['top'] = 0 - world_height*16 - world_offset
	boundaries['bot'] = 0 + world_offset
	
	
func generate_world():
	for x in range(world_width): 
		for y in range(world_height):
			# Get noise value at given cell. 
			var noise_val: float = noise.get_noise_2d(x, y)
			noise_val_arr.append(noise_val)
			
			# Spawn island if the noise val is black (below 0.4). 
			if noise_val > 0.4: spawn_island(Vector2i(x-world_width/2, y-world_height))
			
	## Use this to check range of noise. 
	#print(noise_val_arr.min())
	#print(noise_val_arr.max())
	

const SPIKE = preload("res://scenes/world/hazards/spike.tscn")
const COPPER_ORE = preload("res://scenes/world/ores/base_ore.tscn")

func spawn_spikes(): 
	var cells: Array[Vector2i] = tilemap.get_used_cells(0)
	
	for c in cells: 
		# Check if can place here. 
		# Must be a tile, and be empty above. 
		if not tilemap.get_cell_tile_data(0, Vector2i(c.x, c.y -1)):
			var r = randi() % 100
			if r > 90 and r < 95: 
				# Place spike. 
				var spike_global_pos = tilemap.map_to_local(Vector2i(c.x, c.y-1))
				var spike = SPIKE.instantiate()
				spike.global_position = spike_global_pos
				tilemap.hazards.add_child(spike) 
			elif r > 95: 
				# Place copper. 
				var copper_global_pos = tilemap.map_to_local(Vector2i(c.x, c.y-1))
				var copper = COPPER_ORE.instantiate()
				copper.global_position = copper_global_pos
				tilemap.hazards.add_child(copper) 
			
			# Continue so as not to spawn an enemy here. 
			continue
			
		# End - check if tile above is empty. 
		
		randomly_spawn_enemies(cells, c)
		# Check if ti

func randomly_spawn_enemies(_cells: Array[Vector2i], cell: Vector2i): 
	var tile = tilemap.get_cell_tile_data(0, cell) 
	
	if tile.get_terrain_peering_bit(tilemap.tile_set.CELL_NEIGHBOR_TOP_SIDE):
		tilemap.set_cell(0, cell, 0, Vector2i(13, 7))

func spawn_island(start_pos: Vector2i):
	# Get random island pattern. 
	var r = randi() % tilemap.tile_set.get_patterns_count()
	var pattern: TileMapPattern = tilemap.tile_set.get_pattern(r)
	
	# Dont spawn island if it overlaps with any tiles. 
	for x in pattern.get_size().x+8: 
		for y in pattern.get_size().y+8: 
			if tilemap.get_cell_tile_data(0, Vector2i(start_pos.x + x-4, start_pos.y + y-4)): return
	
	# Spawn the island. 
	tilemap.set_pattern(0, start_pos, pattern)


# Tranistion player upwards. 
# Spawns at the bottom of the above level. 
func _on_player_detector_top_body_entered(_body: Node2D) -> void:
	var enter_params = EnterParams.new() 
	enter_params.player_pos = Vector2(player.global_position.x, boundaries['bot'])
	enter_params.player_state = "flying"
	
	change_wilds_level.emit(Vector2i.UP, enter_params)

# Tranistion player downwards. 
# Spawns at the top of the bottom level. 
func _on_player_detector_bot_body_entered(_body: Node2D) -> void:
	#print(boundaries['top']+50)  # -1470
	var enter_params = EnterParams.new() 
	enter_params.player_pos = Vector2(player.global_position.x, boundaries['top']+50)
	enter_params.player_state = "flying"
	
	change_wilds_level.emit(Vector2i.DOWN, enter_params)
