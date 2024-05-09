extends State 

var distance: float 
var direction: Vector2 
var target: Vector2
var original_tile: Vector2i 

var entity


"""
	About: 
		This moves the helipod 2 cells above a clicked tile. 
		It's seperated from move_to_mouse for clarity's sake. 
"""

func enter(enter_params = null):
	target = enter_params['target']
	original_tile = enter_params['original_tile'] 
	entity = enter_params['entity']

func physics_process(delta: float) -> void:
	# Move towards the mouse's last right clicked position. 
	direction = Globals.get_direction_to_target(actor.center_marker.global_position, target)	
	distance = Globals.get_distance_between_two_targets(actor.center_marker.global_position, target) 
	
	# TODO: Change how far helipod stops from the target. 
	# Stop when near target. 
	if distance < 5: 
		transition.emit(self, 'action', {'tile': original_tile, "entity": entity})
		
	actor.velocity_component.move_freely(delta, direction)	
	actor.move_and_slide()
		
		
		
		

func on_input(event: InputEvent): 
	# Go the where the mouse clicked. 
	if event.is_action_pressed('right_click'):
		transition.emit(self, 'movetomouse')
	# Go to clicked tile. 
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
	
	


