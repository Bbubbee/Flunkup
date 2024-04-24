extends CharacterBody2D

@onready var state_machine: Node = $StateMachine
@onready var center_marker = $General/CenterMarker

# Components.
@onready var velocity_component: VelocityComponent = $Components/VelocityComponent

func _ready() -> void:
	state_machine.init(self) 
	
	Events.position_helipod.connect(_on_position_helipod)


func _on_position_helipod(tile_pos: Vector2):
	var target = tile_pos
	state_machine.force_transition('move', target)
