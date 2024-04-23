extends Node2D
class_name VelocityComponent 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var actor: Node2D
@export var speed: float = 100
@export var acceleration: float = 200
@export var friction: float = 400


# Slows to a stop. 
func stop(delta: float): 
	actor.velocity.x = move_toward(actor.velocity.x, 0, friction*delta)

func move(delta: float):
	pass

func handle_gravity(delta: float): 
	if not actor.is_on_floor():
		actor.velocity.y += gravity * delta


