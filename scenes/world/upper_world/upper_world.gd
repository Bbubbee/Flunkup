extends Node2D

@onready var tilemap: TileMap = $TempTilemap

var world_width: int = 60
var world_height: int = 90

var do_once: bool = true 

@export var noise_texture : NoiseTexture2D
var noise: Noise
var noise_val_arr = []
	
	
func _ready() -> void:
	# Get the noise that we set in the editor. 
	noise = noise_texture.noise
	
	generate_world()

func generate_world():
	for x in range(world_width): 
		for y in range(world_height):
			# Get noise value at given cell. 
			var noise_val: float = noise.get_noise_2d(x, y)
			noise_val_arr.append(noise_val)
			
			if noise_val > 0.4: 
				spawn_island(Vector2i(x, y))
				#tilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(13, 7))
				
			#else: 
				#tilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(3, 1))
				
	print(noise_val_arr.min())
	print(noise_val_arr.max())
	

const SPIKE = preload("res://scenes/world/hazards/spike.tscn")

func spawn_spikes(cells: Array[Vector2i]): 
	for c in cells: 
		# Check if can place spike. 
		if not tilemap.get_cell_tile_data(0, Vector2i(c.x, c.y -1)):
			var r = randi() % 100
			if r > 90: 
				var spike_global_pos = tilemap.map_to_local(Vector2i(c.x, c.y-1))
				var spike = SPIKE.instantiate()
				spike.global_position = spike_global_pos
				tilemap.hazards.add_child(spike) 

	

func spawn_island(start_pos: Vector2i):
	# Get random island pattern. 
	var r = randi() % tilemap.tile_set.get_patterns_count()
	var pattern: TileMapPattern = tilemap.tile_set.get_pattern(r)
	
	# See if this island pattern overlaps with any tiles. 
	for x in pattern.get_size().x+8: 
		for y in pattern.get_size().y+8: 
			if tilemap.get_cell_tile_data(0, Vector2i(start_pos.x + x-4, start_pos.y + y-4)): return
	
	tilemap.set_pattern(0, start_pos, pattern)

	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed('left_click'): 
		var mouse_pos = get_global_mouse_position()
		var tile = tilemap.local_to_map(mouse_pos)
		print(tile) 
	
