extends PlayerState


func physics_process(delta):
	# Basic movement. 
	actor.handle_movement(delta) 
	actor.velocity_component.handle_gravity(delta) 
	actor.flip_nodes()
	
	actor.sprite.frame = 0
	
	actor.move_and_slide() 
	
	# Must be after move and slide.
	# Handles coyote timer and jump buffer.  
	actor.jump_component.handle_jump() 
	
	# Go back to idle state. 
	if actor.velocity.x == 0: transition.emit(self, 'idle') 
	
func on_input(event: InputEvent): 
	if event.is_action_pressed("jump"): actor.jump_component.try_to_jump()
			
	elif event.is_action_pressed('interact') and actor.is_touching_helipod(): 
		transition.emit(self, 'flying')

