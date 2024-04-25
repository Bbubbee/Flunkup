extends CharacterBody2D

@onready var state_machine: Node = $StateMachine
@onready var center_marker = $General/CenterMarker

# Components.
@onready var velocity_component: VelocityComponent = $Components/VelocityComponent

func _ready() -> void:
	state_machine.init(self) 
	Events.player_touched_heli.connect(_on_player_touched_heli)

func _on_player_touched_heli(held: bool):
	if held:
		state_machine.force_transition('carrying')
	else: 
		state_machine.force_transition('idle')

