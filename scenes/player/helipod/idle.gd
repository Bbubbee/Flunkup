extends State



func physics_process(delta: float) -> void:
	actor.velocity_component.stop_freely(delta)
	actor.move_and_slide()

func on_input(event: InputEvent): 
	if event.is_action_pressed('left_click'):
		transition.emit(self, 'move') 
