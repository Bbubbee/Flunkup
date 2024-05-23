extends Level




func _on_transition_area_body_entered(_body):
	change_level.emit("res://scenes/world/upper_world/upper_world.tscn")

