extends Node2D




func _on_transition_area_body_entered(_body):
	SceneTransition.change_scene("res://scenes/world/upper_world/upper_world.tscn")
