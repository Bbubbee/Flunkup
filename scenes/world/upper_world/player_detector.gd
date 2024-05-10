extends Area2D

@onready var shape: CollisionShape2D = $Shape

func init(boundaries: Dictionary):
	shape.shape.a = Vector2i(boundaries['left'], boundaries['top']-32)
	shape.shape.b = Vector2i(boundaries['right'], boundaries['top']-32)
	
	
func _on_body_entered(_body: Node2D) -> void:
	SceneTransition.change_scene("res://scenes/world/upper_world/upper_world.tscn")
