extends Node
class_name LevelManager


@onready var animator: AnimationPlayer = $LevelTransition/Animator

@onready var main_level: Node2D = $MainLevel  # Holds the current_level node.
var current_level: Node2D


# NOTE: Commented these 2 functions because of changes in paramater types.
func _ready() -> void:
	init_level("res://scenes/world/world.tscn")

func init_level(level_path: String):
	var level_resource := load(level_path)
	if level_resource:
		current_level = level_resource.instantiate() 
		current_level.change_level.connect(change_level)
		main_level.call_deferred('add_child', current_level)

func unload_level(): 
	if is_instance_valid(current_level): 
		current_level.queue_free()
		current_level.change_level.disconnect(change_level)
	current_level = null

func change_level(level_path: String, enter_params: EnterParams = null): 
	animator.play("dissolve")
	await animator.animation_finished
	unload_level()
	
	var level_resource := load(level_path)
	if level_resource:
		current_level = level_resource.instantiate() 
		current_level.change_level.connect(change_level)
		call_deferred('transition_level', enter_params)

		animator.play_backwards("dissolve")

# Call this deferred to allow all items to safely queue free,
# and all nodes to load before enter_params are initialised.
func transition_level(enter_params: EnterParams = null):
	main_level.add_child(current_level) 
	
	# Enter params. 
	if enter_params:
		current_level.init(enter_params) 
