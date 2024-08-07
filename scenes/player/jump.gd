extends PlayerState

func enter(_enter_params = null):
	actor.animator.play('idle')

func physics_process(delta):
	# Basic movement. 
	actor.handle_movement(delta) 
	actor.velocity_component.handle_gravity(delta) 
	actor.flip_nodes()
	
	actor.move_and_slide() 
	
	# Must be after move and slide.
	# Handles coyote timer and jump buffer.  
	actor.jump_component.handle_jump() 
	
	if actor.is_on_floor():
		transition.emit(self, 'move')
		
func on_input(event: InputEvent): 			
	if event.is_action_pressed('up') and actor.is_touching_helipod(): 
		transition.emit(self, 'flying')
	
	if event.is_action_pressed("jump"): 
		if actor.jump_component.try_to_jump(): 
			transition.emit(self, 'jump')
