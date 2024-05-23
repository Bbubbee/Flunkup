extends Area2D

@onready var shape: CollisionShape2D = $Shape

func init(boundaries: Dictionary):
	shape.shape.a = Vector2i(boundaries['left'], boundaries['top']-16)
	shape.shape.b = Vector2i(boundaries['right'], boundaries['top']-32)
	
