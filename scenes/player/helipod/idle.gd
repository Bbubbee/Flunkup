extends State

#func _ready():
	#Events.position_helipod.connect(_on_position_helipod)
	#

func physics_process(delta: float) -> void:
	actor.velocity_component.stop_freely(delta)
	actor.move_and_slide()


func on_input(event: InputEvent): 
	# Go to where the mouse was right clicked. 
	if event.is_action_pressed('right_click'):
		transition.emit(self, 'movetomouse') 
	
	if event.is_action_pressed("change_heli_mode"):
		transition.emit(self, 'follow') 
		Events.set_mode.emit(true)
	
	if event.is_action_pressed('left_click'): 
		if actor.tile_map: 
			var tile_map: TileMap = actor.tile_map
			
			# Get the tile the mouse clicked on. 
			var tile_pos = tile_map.get_valid_tile(actor.get_global_mouse_position())
			if not tile_pos: return

			# Get two tiles above the selected tile. Get it's local position too. 
			var local_pos = tile_map.map_to_local(Vector2i(tile_pos.x, tile_pos.y-2))
			transition.emit(self, 'movetotile', {"target": local_pos, "original_tile": tile_pos})
	
	

## A tile has been pressed. Go to that tile. 
#func _on_position_helipod(tile_pos: Vector2, original_tile_pos: Vector2i):
	#var params = {'target': tile_pos, 'original_tile_pos': original_tile_pos}
	#transition.emit(self, 'move', params)
