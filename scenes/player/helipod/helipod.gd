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
	
	These force a transition into a given state. 
	If you don't want to transition from certain states, query their state_name and return. 
"""


## Check for input. 
func _input(event: InputEvent) -> void:
	if event.is_action_pressed('right_click'):
		move_to_mouse()


## Move to the mouse. 
func move_to_mouse(): 
	if state_machine.current_state.state_name == 'action' or state_machine.current_state.state_name == 'carrying':
		return
		
	state_machine.force_transition('movetomouse') 


## The player has interacted with the helipod. 
## Either fly it or drop from it. 
func _on_player_touched_heli(held: bool):
	if held: state_machine.force_transition('carrying')
	else: state_machine.force_transition('idle')


# When the helipod is positioned, store the entity that caused it to do so. 
# The helipod will 'act_upon' it once it reaches it. 
var entity

## The helipod has been positioned by pressing an 'entity' -> tile or interactable object. 
## Position above it and atempt to 'act_upon' it. Ensure the entity has that function. 
func _on_position_helipod(pos: Vector2, e = null):	
	if (state_machine.current_state.state_name == 'follow' 
	or state_machine.current_state.state_name == 'carrying' 
	or state_machine.current_state.state_name == 'action'):
		return
		
	# Position helipod 2 tiles above ore. 
	var new_pos = Vector2(pos.x, pos.y - 16)
	
	entity = e
	state_machine.force_transition('movetotile', new_pos)
