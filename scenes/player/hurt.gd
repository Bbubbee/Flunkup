extends PlayerState


func enter(_enter_params = null):
	actor.concurrent_animator.play('hurt')
