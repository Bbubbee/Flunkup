extends VelocityComponent
class_name PlayerVelocityComponent

@export var flight_gravity: float = 50
@export var fly_up_speed: float = 100
@export var fly_down_speed: float = 100

func fly(delta: float): 
	actor.velocity.y = move_toward(actor.velocity.y, -fly_up_speed, acceleration*delta) 

func fly_down(delta: float):
	actor.velocity.y = move_toward(actor.velocity.y, fly_down_speed, acceleration*delta) 

func handle_flying_gravity(delta: float): 
	if not actor.is_on_floor(): actor.velocity.y += flight_gravity * delta
