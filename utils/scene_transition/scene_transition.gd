extends CanvasLayer

@onready var animator = $Animator

var current_scene

func change_scene(target: String) -> void:
	animator.play("dissolve")
	await animator.animation_finished
	get_tree().change_scene_to_file(target) 
	
	animator.play_backwards("dissolve")


