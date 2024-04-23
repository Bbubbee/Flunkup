extends State


func physics_process(delta):
	actor.move_and_slide()
	
	actor.velocity_component.handle_gravity(delta) 
	actor.jump_component.handle_jump(delta)
	

func on_input(event: InputEvent): 
	var moving = Input.get_axis('left', 'right')
	if moving: transition.emit(self, "move") 
	
	if event.is_action_pressed("jump"): actor.jump_component.try_to_jump()	
