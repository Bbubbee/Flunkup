extends State 

var distance: float 
var direction: Vector2 
var target: Vector2

func enter(_enter_params = null):
	# Either position the helipod above a tile or at the mouse position. 
	target = actor.get_global_mouse_position()
	
	direction = Globals.get_direction_to_target(actor.center_marker.global_position, target)
	distance = Globals.get_distance_between_two_targets(actor.center_marker.global_position, target)


func physics_process(delta: float) -> void:
	# Move towards the mouse's last right clicked position. 
	direction = Globals.get_direction_to_target(actor.center_marker.global_position, target)	
	distance = Globals.get_distance_between_two_targets(actor.center_marker.global_position, target) 
	actor.velocity_component.move_freely(delta, direction)
	
	# TODO: Change how far helipod stops from the target. 
	# Stop when near target. 
	if distance < 5: 
		transition.emit(self, 'idle')
	
	actor.move_and_slide()
	

func on_input(event: InputEvent): 
	# Target the new mouse position. 
	if event.is_action_pressed('right_click'):
		target = actor.get_global_mouse_position()
		direction = Globals.get_direction_to_target(actor.center_marker.global_position, actor.get_global_mouse_position())

	if event.is_action_pressed('left_click'): 
		if actor.tile_map: 
			var tile_map: TileMap = actor.tile_map
			
			# Get the tile the mouse clicked on. 
			var tile_pos = tile_map.get_valid_tile(actor.get_global_mouse_position())
			if not tile_pos: return
			
			# Get two tiles above the selected tile. Get it's local position too. 
			var local_pos = tile_map.map_to_local(Vector2i(tile_pos.x, tile_pos.y-2))
			transition.emit(self, 'movetotile', {"target": local_pos, "original_tile": tile_pos})
		
	if event.is_action_pressed("change_heli_mode"):
		transition.emit(self, 'follow') 
		Events.set_mode.emit(true)

	
	


