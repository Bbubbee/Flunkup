extends State



func physics_process(delta: float) -> void:
	# Get distance to player. 
	var distance = Globals.get_distance_between_two_targets(actor.global_position, actor.player.global_position)
	var direction = Globals.get_direction_to_target(actor.global_position, actor.player.global_position)
	
	if distance < 40: 
		actor.velocity_component.stop_freely(delta)
	else: 
		actor.velocity_component.move_freely(delta, direction)
	
	actor.move_and_slide()


func on_input(event: InputEvent):
	if event.is_action_pressed("change_heli_mode"):
		Events.set_mode.emit(false)
		transition.emit(self, 'idle')
