extends State 

var distance: float 
var direction: Vector2 
var target: Vector2


"""
	About: 
		This moves the helipod 2 cells above a clicked tile. 
		It's seperated from move_to_mouse for clarity's sake. 
"""


func enter(enter_params = null):
	target = enter_params


func physics_process(delta: float) -> void:
	# Move towards the mouse's last right clicked position. 
	direction = Globals.get_direction_to_target(actor.center_marker.global_position, target)	
	distance = Globals.get_distance_between_two_targets(actor.center_marker.global_position, target) 
	
	# TODO: Change how far helipod stops from the target. 
	# Stop when near target. 
	if distance < 10: 
		transition.emit(self, 'action')
		#transition.emit(self, 'action', {'tile': original_tile, "entity": entity})
		
	actor.velocity_component.move_freely(delta, direction)	
	actor.move_and_slide()
		

func on_input(event: InputEvent): 
	# Go the where the mouse clicked. 
	if event.is_action_pressed('right_click'):
		transition.emit(self, 'movetomouse')
	
	if event.is_action_pressed("change_heli_mode"):
		transition.emit(self, 'follow') 
		Events.set_mode.emit(true)
	
	


