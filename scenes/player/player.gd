extends CharacterBody2D


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
