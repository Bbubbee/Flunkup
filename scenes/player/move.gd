extends PlayerState


func physics_process(delta):
	actor.handle_movement(delta) 
	actor.velocity_component.handle_gravity(delta) 
	actor.flip_nodes()
	
	actor.move_and_slide() 
	
	actor.jump_component.handle_jump() 
	
	
	
	
	# Go back to idle state. 
	if actor.velocity.x == 0: transition.emit(self, 'idle') 
	
func on_input(event: InputEvent): 
	if event.is_action_pressed("jump"): actor.jump_component.try_to_jump()	
