extends Level

@onready var tilemap: TileMap = $TempTilemap

var world_width: int = 60
var world_height: int = 90
@onready var player_camera: Camera2D = $PlayerCamera
@onready var player: Player = $Player

var do_once: bool = true 

@export var noise_texture : NoiseTexture2D
var noise: Noise
var noise_val_arr = []
	
@onready var top_area: Area2D = $TopArea

func _ready() -> void:
	# Get the noise that we set in the editor. 
	noise = noise_texture.noise
	
	generate_world()
	spawn_spikes()
	setup_boundaries()
	
	top_area.init(boundaries)
	player_camera.init(boundaries) 
	player.init('flying', Vector2(0, 0+125))
	

var boundaries = {}
func setup_boundaries(): 
	var world_offset = 5*16
	var island_offset = 23*16 
	
	boundaries['left'] = 0 - (world_width*16)/2 - world_offset
	boundaries['right'] = 0 + (world_width*16)/2 + world_offset + island_offset
	boundaries['top'] = 0 - world_height*16 - world_offset
	
	

func generate_world():
	for x in range(world_width): 
		for y in range(world_height):
			# Get noise value at given cell. 
			var noise_val: float = noise.get_noise_2d(x, y)
			noise_val_arr.append(noise_val)
			
			# Spawn island. 
			if noise_val > 0.4: spawn_island(Vector2i(x-world_width/2, y-world_height))
			
	## Use this to check range of noise. 
	#print(noise_val_arr.min())
	#print(noise_val_arr.max())
	

const SPIKE = preload("res://scenes/world/hazards/spike.tscn")
const COPPER_ORE = preload("res://scenes/world/ores/copper_ore.tscn")

func spawn_spikes(): 
	var cells = tilemap.get_used_cells(0)
	
	for c in cells: 
		# Check if can place spike. 
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

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed('left_click'): 
		var mouse_pos = get_global_mouse_position()
		var _tile = tilemap.local_to_map(mouse_pos)

	


func _on_top_area_body_entered(_body: Node2D) -> void:
	change_level.emit("res://scenes/world/upper_world/upper_world.tscn")
