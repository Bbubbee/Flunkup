extends State 


"""
	About: 
		The helipod was moved 2 tiles above a clicked on tile. 
		It will then act on that tile based on what the tile is. 
		E.g., grass = till, dirt = water. 
"""

func _ready() -> void:
	state_name = 'action'

func enter(_enter_params = null):
	actor.animator_2.play('shake')		


func physics_process(delta: float) -> void:
	actor.velocity_component.stop_freely(delta)
	actor.move_and_slide()

func _on_animator_2_animation_finished(anim_name):
	if anim_name == 'shake': 	
		
		# If this is an ore, mine it.
		if actor.entity: 
			if actor.entity.has_method('act_upon'):
				actor.entity.act_upon()
			
		transition.emit(self, 'idle')


