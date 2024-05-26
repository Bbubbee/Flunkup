extends CharacterBody2D

# General 
@onready var state_machine: StateMachine = $StateMachine
@onready var animator: AnimationPlayer = $General/Animator
@onready var animator_2: AnimationPlayer = $General/Animator2
@onready var center_marker: Marker2D = $General/CenterMarker

@export var tile_map: TileMap 
@export var player: Player

# Components.
@onready var velocity_component: VelocityComponent = $Components/VelocityComponent


# Can be initialised carrying the player. 
func init(inital_state: String):
	state_machine.force_transition(inital_state)


func _ready() -> void:
	state_machine.init(self) 
	
	# Connect signals. 
	Events.position_helipod.connect(_on_position_helipod)
	Events.player_touched_heli.connect(_on_player_touched_heli)
	


"""
	STATE MACHINE OVERRIDES 
	
	These activates a certain state, regardless of the current state. 
"""




func _on_player_touched_heli(held: bool):
	if held: state_machine.force_transition('carrying')
	else: state_machine.force_transition('idle')



var entity

# This technically passes a tile. Ergo, the tile doesn't have to be determined. 
func _on_position_helipod(pos: Vector2, e):
	entity = e
	state_machine.force_transition('movetotile', pos)
