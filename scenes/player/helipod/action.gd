extends State 

var tile_to_act_on
var entity

"""
	About: 
		The helipod was moved 2 tiles above a clicked on tile. 
		It will then act on that tile based on what the tile is. 
		E.g., grass = till, dirt = water. 
"""

func enter(enter_params = null):
	tile_to_act_on = enter_params['tile']
	entity = enter_params['entity']
	actor.animator_2.play('shake')		
	
	print(tile_to_act_on)	

func physics_process(delta: float) -> void:
	actor.velocity_component.stop_freely(delta)
	actor.move_and_slide()

func _on_animator_2_animation_finished(anim_name):
	if anim_name == 'shake': 
		if entity: 
			entity.mine()
		else: 
			Events.process_tile.emit(tile_to_act_on)			
		transition.emit(self, 'idle')


