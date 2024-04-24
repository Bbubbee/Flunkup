extends State 

var distance: float 
var direction: Vector2 
var target: Vector2

func enter(_enter_params = null):
	# Get direction and distance of mouse.
	target = actor.get_global_mouse_position()
	direction = Globals.get_direction_to_target(actor.global_position, actor.get_global_mouse_position())
	distance = Globals.get_distance_between_two_targets(actor.global_position, actor.get_global_mouse_position())


func physics_process(delta: float) -> void:
	distance = Globals.get_distance_between_two_targets(actor.global_position, actor.get_global_mouse_position()) 
	print(distance) 	
	
	# TODO: Change mouse click position detection. 
	if distance < 30: 
		transition.emit(self, 'idle')
	
	actor.velocity_component.move_freely(delta, direction)
	actor.move_and_slide()
	

func on_input(event: InputEvent): 
	if event.is_action_pressed('left_click'):
		direction = Globals.get_direction_to_target(actor.global_position, actor.get_global_mouse_position())

