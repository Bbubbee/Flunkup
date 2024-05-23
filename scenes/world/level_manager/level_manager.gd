extends Node

"""
	A level consists of a stack of levels.
"""

# Stack of levels. 
@onready var animator: AnimationPlayer = $LevelTransition/Animator


var current_level: Level
@onready var main_level: Node2D = $MainLevel

func _ready() -> void:
	change_level("res://scenes/world/world.tscn")

func unload_level(): 
	if is_instance_valid(current_level): 
		current_level.queue_free()
	current_level = null

func change_level(level_path: String): 
	animator.play("dissolve")
	await animator.animation_finished
	unload_level()
	
	var level_resource := load(level_path)
	if level_resource:
		current_level = level_resource.instantiate() 
		current_level.change_level.connect(change_level)
		main_level.call_deferred('add_child', current_level)
		animator.play_backwards("dissolve")
