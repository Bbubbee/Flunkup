extends LevelManager


var level_stack: Array[Level] = []
var level_index: int = 0

const WILD_LEVEL = preload("res://scenes/world/upper_world/upper_world.tscn")

# NOTE: This is called in ready. It creates a ground level. 
func init_level(level_path: String):
	var level_resource := load(level_path)
	if level_resource:
		current_level = level_resource.instantiate() 
		current_level.change_level.connect(change_level)
		current_level.go_up_level.connect(go_up_level)
		current_level.go_down_level.connect(go_down_level)
		
		main_level.call_deferred('add_child', current_level)

#func _physics_process(delta: float) -> void:
	#print(level_stack)
		

func unload_level(): 
	if is_instance_valid(current_level): 
		current_level.queue_free()
		current_level.disconnect('go_up_level', go_up_level)
		current_level.disconnect('go_down_level', go_down_level)
	current_level = null

	

func go_up_level(enter_params: EnterParams = null):
	# Play dissolve in animation. 
	animator.play("dissolve")
	await animator.animation_finished
	
	# Try and go up a level. 
	level_index += 1 
	if level_index < level_stack.size(): 
		unload_level()	
		current_level = level_stack[level_index]
	else:
		# Put the current level into the stack.
		level_stack.push_back(current_level.duplicate()) 
		unload_level()
		current_level = WILD_LEVEL.instantiate()
		

	
	# Connect signals for current level.
	current_level.connect('go_up_level', go_up_level)
	current_level.connect('go_down_level', go_down_level)
	
	# Go to the next level.
	main_level.add_child(current_level) 
	
	# Enter params. 
	if enter_params:
		current_level.init(enter_params) 
	
	# Play dissolve out animation. 
	animator.play_backwards("dissolve")
	


func go_down_level(enter_params: EnterParams = null): 
	# Play dissolve in animation. 
	animator.play("dissolve")
	await animator.animation_finished
	
	level_index -= 1 
	unload_level()

	current_level = level_stack[level_index]
	
	print(current_level)
	
	# Connect signals for current level.
	current_level.connect('go_up_level', go_up_level)
	current_level.connect('go_down_level', go_down_level)
	
	# Go to the next level.
	main_level.call_deferred('add_child', current_level) 
	#
	## Enter params. 
	#if enter_params: 
		#current_level.init(enter_params)
	#
	# Play dissolve out animation. 
	animator.play_backwards("dissolve")
