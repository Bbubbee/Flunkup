extends Node


# Assume the current world is the bottom world.
var current_world: int = 0

# Tiles the user has affected. Tilled, watered, planted, etc.
var affected_tiles: Array[Types.Tile] = []

var current_day: int = 0 

# Stores all the tiles that have been affected so as to load them later. 
func add_affected_tile(tile: Types.Tile) -> void:
	# TODO: Check if tile exists within array.
	if tile in affected_tiles: return

	affected_tiles.append(tile)
	
	# Check the position: Vector2i and type: maybe custom data

## Manually advance the day with 'p'.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("increase_day"):
		current_day += 1 
		Events.increase_day.emit(current_day)

