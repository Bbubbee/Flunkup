extends Node2D

@onready var tilemap: TileMap = $TempTilemap

var world_width: int = 60
var world_height: int = 90

var do_once: bool = true 

@export var noise_texture : NoiseTexture2D
var noise: Noise
var noise_val_arr = []


func generate_world():
	for x in range(world_width): 
		for y in range(world_height):
			var noise_val: float = noise.get_noise_2d(x, y)
			noise_val_arr.append(noise_val)
			if noise_val > 0.4: 
				spawn_island(Vector2i(x, y))
				#tilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(13, 7))
				
			#else: 
				#tilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(3, 1))
				
	print(noise_val_arr.min())
	print(noise_val_arr.max())
	
	
	
func _ready() -> void:
	noise = noise_texture.noise
	generate_world()
	#randomize()
	#
	#spawn_island_2(Vector2i(0, 0))
	
	# Spawn floating islands. 
	#for x in world_width:
		#for y in world_height: 
			##var new_x = x - world_width/2
			##var new_y = y - world_height
			#
			## Randomly spawn an island. 
			#var r = randi() % 100 			
			#if r > 80: spawn_island(Vector2i(x, y))
			

			
			# Island check. 
			#if do_once: 
				#do_once = false
				#print(x, y)
				#
				## Spawn random island pattern. 
				#var r = randi() % tilemap.tile_set.get_patterns_count()
				#var pattern: TileMapPattern = tilemap.tile_set.get_pattern(0)
				#tilemap.set_pattern(0, Vector2i(x, y), pattern)
				#print(pattern.get_size())
			
	# End spawn floating islands. 
	
	#var used_cells = tilemap.get_used_cells(0)
	#spawn_spikes(used_cells)

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

var check_width: int = 25
var check_height: int = 90

var recursion_test = 0

# Spawn island above the given start position. 
func spawn_island_2(start_pos: Vector2i):
	var r = randi() % tilemap.tile_set.get_patterns_count()
	var pattern: TileMapPattern = tilemap.tile_set.get_pattern(r)
	var pos_y: int = start_pos.y - pattern.get_size().y - (randi_range(6, 10))
	var new_pos = Vector2i(start_pos.x, pos_y)
	tilemap.set_pattern(0, new_pos, pattern)
	
	recursion_test += 1
	print(recursion_test)
	if recursion_test < 3: 
		spawn_island_2(new_pos)		
	else: 
		return	

	
	#
	## Spawn an island directly above it. 
	#var r2 = randi() % tilemap.tile_set.get_patterns_count()
	#var pattern2: TileMapPattern = tilemap.tile_set.get_pattern(r2)
	#var pos_y: int = start_pos.y - pattern2.get_size().y - 10
	#var pos =  Vector2i(start_pos.x, pos_y) 
	#tilemap.set_pattern(0, pos, pattern2)
	
	
	
	

func spawn_island(start_pos: Vector2i):
	# Get random island pattern. 
	var r = randi() % tilemap.tile_set.get_patterns_count()
	var pattern: TileMapPattern = tilemap.tile_set.get_pattern(r)
	
	# See if this island pattern overlaps with any tiles. 
	for x in pattern.get_size().x+8: 
		for y in pattern.get_size().y+8: 
			if tilemap.get_cell_tile_data(0, Vector2i(start_pos.x + x-4, start_pos.y + y-4)): return
	
	
	## Check in a box around the tile and see if there are any tiles there. 	
	#for x in check_width:
		#for y in check_height:
			#if tilemap.get_cell_tile_data(0, Vector2i(start_pos.x + x, start_pos.y + y)): return
	
	# Spawn random island pattern. 
	#var r = randi() % tilemap.tile_set.get_patterns_count()
	#var pattern: TileMapPattern = tilemap.tile_set.get_pattern(r)
	tilemap.set_pattern(0, start_pos, pattern)

	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed('left_click'): 
		var mouse_pos = get_global_mouse_position()
		var tile = tilemap.local_to_map(mouse_pos)
		print(tile) 
	
	

"""
	How do I check if there are nearby tiles? 
	
	Can I get the width and height of a tile map pattern? 
"""
