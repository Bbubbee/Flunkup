extends Node2D

@onready var tilemap: TileMap = $TempTilemap

var world_width: int = 80
var world_height: int = 60


func _ready() -> void:
	randomize()
	
	# Spawn floating islands. 
	for x in world_width:
		for y in world_height: 
			var new_x = x - world_width/2
			var new_y = y - world_height
			
			
			# Randomly spawn an island. 
			var r = randi() % 100 			
			if r > 95: spawn_island(Vector2i(new_x, new_y))
	# End spawn floating islands. 
	
	var used_cells = tilemap.get_used_cells(0)
	spawn_spikes(used_cells)


func spawn_spikes(cells: Array[Vector2i]): 
	for c in cells: 
		# Check if can place spike. 
		if not tilemap.get_cell_tile_data(0, Vector2i(c.x, c.y -1)):
			var r = randi() % 100
			if r > 90: 
				tilemap.set_cell(0, Vector2i(c.x, c.y -1), 0, Vector2i(1, 5))

var check_width: int = 25
var check_height: int = 90

func spawn_island(start_pos: Vector2i):
	# Check in a box around the tile and see if there are any tiles there. 	
	for x in check_width:
		for y in check_height:
			if tilemap.get_cell_tile_data(0, Vector2i(start_pos.x + x, start_pos.y + y)): return
	
	# Spawn random island pattern. 
	var r = randi() % tilemap.tile_set.get_patterns_count()
	var pattern: TileMapPattern = tilemap.tile_set.get_pattern(r)
	tilemap.set_pattern(0, start_pos, pattern)
	
	
	
	
	
	
	
	
	
	
	
	
	#tilemap.set_pattern(0, start_pos, 1)
	# TODO: Check if can spawn island. 
	#for x in island_width: 
		#for y in island_height:
			#if tilemap.get_cell_tile_data(0, Vector2i(start_pos.x+x, start_pos.y + y)): 
				#return 
	#
	#for x in island_width: 
		#for y in island_height:
			#tilemap.set_cell(0, Vector2i(start_pos.x + x, start_pos.y + y), 0, Vector2i(1, 1))
			
			#else: 
				#if not tilemap.get_cell_tile_data(0, Vector2i(x, y)):
					#tilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(18, 5))
				#
			#
			#if r > 95:
				#tilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(13, 7))
				#
			#else: 
				#tilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(18, 5))
				#
