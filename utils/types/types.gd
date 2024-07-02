extends Node

class Tile: 
	var position: Vector2i 
	var state: StringName
	
	func init(pos, s):
		position = pos
		state = s
	
	
