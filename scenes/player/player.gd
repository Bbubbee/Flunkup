extends CharacterBody2D
class_name Player

@onready var sprite: Sprite2D = $General/Sprite

# Components.
@onready var velocity_component = $Components/VelocityComponent
@onready var jump_component = $Components/JumpComponent
@onready var state_machine = $StateMachine

func _ready():
	state_machine.init(self)
	
func handle_movement(delta): 
	var direction = Input.get_axis("left", "right")
	if direction: velocity_component.move(delta, direction)
	else: velocity_component.stop(delta)


## Flip the nodes to face wherever the player is moving. 
func flip_nodes(): 
	if velocity.x > 0: 
		sprite.flip_h = false 
		#heli_pod.position.x = -4
		
	elif velocity.x < 0: 
		sprite.flip_h = true 
		#heli_pod.position.x = 4
