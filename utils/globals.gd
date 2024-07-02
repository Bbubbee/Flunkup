extends Node


func get_distance_between_two_targets(a: Vector2, b: Vector2) -> float: 
	return (a - b).length()

func get_direction_to_target(subject: Vector2, target: Vector2): 
	return (target - subject).normalized()






