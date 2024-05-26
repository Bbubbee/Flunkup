extends LevelManager


# You must ascend 5 wild levels to reach the next checkpoint. 
var wilds_level: int = 0 

var wild_level_path: String = 'res://scenes/world/upper_world/wild_world.tscn'
var world_path: String = 'res://scenes/world/world.tscn'
var world_checkpoint_path: String = 'res://scenes/world/checkpoint_worlds/world_checkpoint.tscn'

func _ready() -> void:
	init_level(world_checkpoint_path)

func init_level(level_path: String):
	# Configure the wilds level based on the starting level (world or checkpoint) 
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






"""
	OLD CODE
	
	I could not find a way to retain previous levels in code. This was an attempt. 
"""

#var level_stack: Array[Level] = []
#var level_index: int = 0
#
#const WILD_LEVEL = preload("res://scenes/world/upper_world/upper_world.tscn")

# NOTE: This is called in ready. It creates a ground level. 
#func init_level(level_path: String):
	#var level_resource := load(level_path)
	#if level_resource:
		#current_level = level_resource.instantiate() 
		#current_level.change_level.connect(change_level)
		#current_level.go_up_level.connect(go_up_level)
		#current_level.go_down_level.connect(go_down_level)
		#
		#main_level.call_deferred('add_child', current_level)
		#
#
#func unload_level(): 
	#if is_instance_valid(current_level): 
		#current_level.queue_free()
		#current_level.disconnect('go_up_level', go_up_level)
		#current_level.disconnect('go_down_level', go_down_level)
	#current_level = null	
#
#func go_up_level(enter_params: EnterParams = null):
	## Play dissolve in animation. 
	#animator.play("dissolve")
	#await animator.animation_finished
	#
	## Try and go up a level. 
	#level_index += 1 
	#if level_index < level_stack.size(): 
		#unload_level()	
		#current_level = level_stack[level_index]
	#else:
		## Put the current level into the stack.
		#level_stack.push_back(current_level.duplicate()) 
		#unload_level()
		#current_level = WILD_LEVEL.instantiate()
		#
#
	#
	## Connect signals for current level.
	#current_level.connect('go_up_level', go_up_level)
	#current_level.connect('go_down_level', go_down_level)
	#
	## Go to the next level.
	#main_level.add_child(current_level) 
	#
	## Enter params. 
	#if enter_params:
		#current_level.init(enter_params) 
	#
	## Play dissolve out animation. 
	#animator.play_backwards("dissolve")
	#
#func go_down_level(enter_params: EnterParams = null): 
	## Play dissolve in animation. 
	#animator.play("dissolve")
	#await animator.animation_finished
	#
	#level_index -= 1 
	#unload_level()
#
	#current_level = level_stack[level_index]
	#
	#print(current_level)
	#
	## Connect signals for current level.
	#current_level.connect('go_up_level', go_up_level)
	#current_level.connect('go_down_level', go_down_level)
	#
	## Go to the next level.
	#main_level.call_deferred('add_child', current_level) 
	##
	### Enter params. 
	##if enter_params: 
		##current_level.init(enter_params)
	##
	## Play dissolve out animation. 
	#animator.play_backwards("dissolve")
