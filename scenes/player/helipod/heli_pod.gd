extends CharacterBody2D

@onready var state_machine: Node = $StateMachine

# Components.
@onready var velocity_component: VelocityComponent = $Components/VelocityComponent

func _ready() -> void:
	state_machine.init(self) 
