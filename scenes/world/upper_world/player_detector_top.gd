extends Area2D

@onready var shape: CollisionShape2D = $Shape

func init(boundaries: Dictionary, location: Vector2i):
	if location == Vector2i.UP:
		shape.shape.a = Vector2i(boundaries['left'], boundaries['top'])
		shape.shape.b = Vector2i(boundaries['right'], boundaries['top'])
	elif location == Vector2i.DOWN: 
		shape.shape.a = Vector2i(boundaries['left'], boundaries['bot']+100)
		shape.shape.b = Vector2i(boundaries['right'], boundaries['bot']+100)
	else:
		print("ERROR: Location of player detector not set.")
	
