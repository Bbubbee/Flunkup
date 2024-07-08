extends Node

## These are the tiles the player has affected.
## Save it and load it later. 
class Tile: 
	var position: Vector2i 
	var state: StringName
	
	func init(pos, s):
		position = pos
		state = s
