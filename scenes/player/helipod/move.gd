extends State 

var distance: float 
var direction: Vector2 
var target: Vector2

func _ready():
	Events.position_helipod.connect(_on_position_helipod)

func enter(_enter_params = null):
	# Either position the helipod above a tile or at the mouse position. 
	if _enter_params: target = _enter_params
	else: target = actor.get_global_mouse_position()
		
	direction = Globals.get_direction_to_target(actor.center_marker.global_position, target)
	distance = Globals.get_distance_between_two_targets(actor.center_marker.global_position, target)


func physics_process(delta: float) -> void:
	# Move towards the mouse's last clicked position. 
	direction = Globals.get_direction_to_target(actor.center_marker.global_position, target)	
	distance = Globals.get_distance_between_two_targets(actor.center_marker.global_position, target) 
	
	# TODO: Change mouse click position detection. 
	# Stop when near target. 
	if distance < 20: 
		transition.emit(self, 'idle')
	
	actor.velocity_component.move_freely(delta, direction)
	actor.move_and_slide()
	

func on_input(event: InputEvent): 
	# Target the new mouse position. 
	if event.is_action_pressed('right_click'):
		target = actor.get_global_mouse_position()
		direction = Globals.get_direction_to_target(actor.center_marker.global_position, actor.get_global_mouse_position())


# A tile has been pressed. Go to that tile. 
func _on_position_helipod(tile_pos: Vector2):
	target = tile_pos


