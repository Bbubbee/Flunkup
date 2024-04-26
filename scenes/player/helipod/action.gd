extends State 

var tile_to_act_on

func enter(enter_params = null):
	tile_to_act_on = enter_params
	actor.animator_2.play('shake')			

func physics_process(delta: float) -> void:
	actor.velocity_component.stop_freely(delta)
	actor.move_and_slide()
	

func _on_animator_2_animation_finished(anim_name):
	if anim_name == 'shake': 
		Events.process_tile.emit(tile_to_act_on)	
		transition.emit(self, 'idle')
