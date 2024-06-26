extends PlayerState


func physics_process(delta):
	actor.move_and_slide()
	actor.sprite.frame = 0
	actor.velocity_component.handle_gravity(delta) 
	
	# Must be after move and slide.
	# Handles coyote timer and jump buffer.  
	actor.jump_component.handle_jump() 
	

func on_input(event: InputEvent): 
	var moving = Input.get_axis('left', 'right')
	if moving: transition.emit(self, "move") 
	
	if event.is_action_pressed("jump"): actor.jump_component.try_to_jump()
	elif event.is_action_pressed('up') and actor.is_touching_helipod(): 
		transition.emit(self, 'flying')
