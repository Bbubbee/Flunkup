extends PlayerState

@onready var helipod_stamina_bar: TextureProgressBar = $"../../UI/HelipodStaminaBar"

func enter(_enter_params = null):
	actor.velocity.y = 0
	actor.sprite.frame = 1
	
	# Relinquish control from the helipod scene. 
	Events.player_touched_heli.emit(true)
	
	helipod_stamina_bar.visible = true
	helipod_stamina_bar.is_active = true
	


func physics_process(delta):
	# Move left or right. 
	actor.handle_movement(delta)
	actor.move_and_slide()
	actor.flip_nodes()
	
	# Keep the helipod on the player. 
	actor.helipod.global_position = Vector2(actor.global_position.x, actor.global_position.y-30)
	
	# Fly up or down. 
	if Input.is_action_pressed("jump") and helipod_stamina_bar.value > 0.5: 
		helipod_stamina_bar.deplete(1)

		actor.velocity_component.fly(delta)
		actor.velocity_component.handle_flying_gravity(delta)
		
		
	# Don't apply gravity when flying downwards. 
	elif Input.is_action_pressed('down'): 
		actor.velocity_component.fly_down(delta)
		helipod_stamina_bar.replenish(0.5)
	else: 
		actor.velocity_component.handle_flying_gravity(delta)
		helipod_stamina_bar.replenish(0.5)
	
	if actor.is_on_floor(): helipod_stamina_bar.replenish(0.5)
	

func on_input(event):
	# Drop from the helipod. 
	if event.is_action_pressed('interact'): 
		transition.emit(self, 'idle')
		Events.player_touched_heli.emit(false)
	
	# Jump from the helipod. 
	elif event.is_action_pressed('up'): 
		actor.jump_component.second_jump()
		transition.emit(self, 'jump')
		Events.player_touched_heli.emit(false)


func exit():
	helipod_stamina_bar.visible = false
	helipod_stamina_bar.is_active = false
	
		
		
		



