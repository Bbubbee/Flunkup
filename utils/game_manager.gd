extends Node


# Assume the current world is the bottom world. 
var current_world: int = 0 

# Tiles the user has affected. Till, watered, planted, etc. 
var affected_tiles: Array[Types.Tile] = []

func add_affected_tile(tile: Types.Tile) -> void: 
	print('adding tile')
	
	#print(tile.position)
	
	# TODO: Check if tile exists within array. 
	if tile in affected_tiles:
		print('im here')
		return
		
	affected_tiles.append(tile)
		
	# Check the position: Vector2i and type: maybe custom data
