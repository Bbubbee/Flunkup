extends Node2D


@onready var state_machine: StateMachine = $StateMachine
@onready var velocity_component: VelocityComponent = $Components/VelocityComponent


func _ready() -> void:
	state_machine.init(self)
