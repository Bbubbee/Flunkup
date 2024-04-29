extends Node2D
class_name VelocityComponent 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var actor: Node2D
@export var speed: float = 200
@export var acceleration: float = 800
@export var friction: float = 800


# Slows to a stop. 
func stop(delta: float): 
	actor.velocity.x = move_toward(actor.velocity.x, 0, friction*delta)

# Only moves in the x direction. 
func move(delta: float, direction: float):
	actor.velocity.x = move_toward(actor.velocity.x, speed*direction, acceleration*delta) 

# Move in the x and y direction .
func move_freely(delta: float, direction: Vector2):
	actor.velocity.x = move_toward(actor.velocity.x, speed*direction.x, acceleration*delta) 
	actor.velocity.y = move_toward(actor.velocity.y, speed*direction.y, acceleration*delta) 


func stop_freely(delta: float):
	actor.velocity.x = move_toward(actor.velocity.x, 0, friction*delta)
	actor.velocity.y = move_toward(actor.velocity.y, 0, friction*delta)

func handle_gravity(delta: float): 
	if not actor.is_on_floor(): actor.velocity.y += gravity * delta


