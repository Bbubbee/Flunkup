extends State

#func _ready() -> void:
	#Events.position_helipod.connect(position_helipod)

func physics_process(delta: float) -> void:
	actor.velocity_component.stop_freely(delta)
	actor.move_and_slide()


func on_input(event: InputEvent): 
	# Go to where the mouse was right clicked. 
	if event.is_action_pressed('right_click'):
		transition.emit(self, 'movetomouse') 
	
	# Go to follow mode. 
	if event.is_action_pressed("change_heli_mode"):
		transition.emit(self, 'follow') 
		Events.set_mode.emit(true)
	
	# Go to the clicked tile. 
	if event.is_action_pressed('left_click'): 
		pass
		#position_helipod()
	

#func position_helipod(pos: Vector2 = Vector2.ZERO, entity = null): 
	#if not actor.tile_map: return
	#
	#var tile_map: WorldTileMap = actor.tile_map
	#var tile_pos
	#
	## Helipod can be positioned to a Tile or Entity (ore, tree, etc.) 
	#
	#if pos: 
		## Entity. 
		#tile_pos = tile_map.get_tile(pos)
	#else: 
		## Tile. 
		#tile_pos = tile_map.get_valid_tile(actor.get_global_mouse_position())
		#
		#
	## Get the tile the mouse clicked on. 
	#if not tile_pos: return
	#
	## Get custom data of the tile. 
	##var custom_data = tile_map.get_custom_data_string(tile_pos, 0)
#
	## Get two tiles above the selected tile. Get it's local position too. 
	#var local_pos = tile_map.map_to_local(Vector2i(tile_pos.x, tile_pos.y-2))
	#transition.emit(self, 'movetotile', {"target": local_pos, "original_tile": tile_pos, "entity": entity})
	
