extends LevelManager


# You must ascend 5 wild levels to reach the next checkpoint. 
var wilds_level: int = 0 

var wild_level_path: String = 'res://scenes/world/upper_world/wild_world.tscn'
var world_path: String = 'res://scenes/world/world.tscn'
var world_checkpoint_path: String = 'res://scenes/world/checkpoint_worlds/world_checkpoint.tscn'

@onready var label: Label = $CanvasLayer/Label


func _ready() -> void:
	init_level(world_path)
	

## Initialise the starting level. 
## @param: level_path -> The starting level. 
## Will change the wilds_level based on the starting level. 
func init_level(level_path: String):
	if level_path == world_checkpoint_path: wilds_level = 5
	else: wilds_level = 0 
	
	var level_resource := load(level_path)
	if level_resource:
		current_level = level_resource.instantiate() 
		current_level.change_level.connect(change_level)
		current_level.change_wilds_level.connect(change_wilds_level)
		main_level.call_deferred('add_child', current_level)


# Either go up or down a wilds level. 
# Will generate a new, random wild level each time. 
func change_wilds_level(dir: Vector2i = Vector2i.UP, enter_params: EnterParams = null):	
	# Go up. 
	if dir == Vector2i.UP: wilds_level += 1		
	# Go down. 
	else: wilds_level -= 1
	
	print(wilds_level)
	
	## Check which level to go to. 
	
	# Go to the bottom floor. 
	if wilds_level == 0: 
		# Override the enter params for the bottom floor. 
		enter_params.player_pos.y = -420
		change_level(world_path, enter_params)
	# Go to a checkpoint level. 
	elif wilds_level >= 5:
		change_level(world_checkpoint_path, enter_params)
		
	# Go to a new wilds level. 
	else: 
		change_level(wild_level_path, enter_params)
	
	label.text = str(wilds_level)
	

func unload_level(): 
	if is_instance_valid(current_level): 
		current_level.queue_free()
		current_level.change_level.disconnect(change_level)
		current_level.change_wilds_level.disconnect(change_wilds_level)
	current_level = null


func change_level(level_path: String, enter_params: EnterParams = null): 
	animator.play("dissolve")
	await animator.animation_finished
	unload_level()
	
	var level_resource := load(level_path)
	if level_resource:
		current_level = level_resource.instantiate() 
		current_level.change_level.connect(change_level)
		current_level.change_wilds_level.connect(change_wilds_level)
		call_deferred('transition_level', enter_params)

		animator.play_backwards("dissolve")

# Call this deferred to allow all items to safely queue free,
# and all nodes to load before enter_params are initialised.
func transition_level(enter_params: EnterParams = null):
	main_level.add_child(current_level) 
	
	# Enter params. 
	if enter_params:
		current_level.init(enter_params) 
