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
		
	if event.is_action_pressed('right_click'):
		transition.emit(self, 'movetomouse') 
	
	if event.is_action_pressed('left_click'): 
		if actor.tile_map: 
			var tile_map: TileMap = actor.tile_map
			
			# Get the tile the mouse clicked on. 
			var tile_pos = tile_map.get_valid_tile(actor.get_global_mouse_position())
			if not tile_pos: return

			# Get two tiles above the selected tile. Get it's local position too. 
			var local_pos = tile_map.map_to_local(Vector2i(tile_pos.x, tile_pos.y-2))
			transition.emit(self, 'movetotile', {"target": local_pos, "original_tile": tile_pos})
