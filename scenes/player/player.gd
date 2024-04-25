extends CharacterBody2D
class_name Player

# General. 
@onready var sprite: Sprite2D = $General/Sprite

# Components.
@onready var velocity_component: PlayerVelocityComponent = $Components/VelocityComponent
@onready var jump_component: JumpComponent = $Components/JumpComponent
@onready var state_machine = $StateMachine

@export var helipod: CharacterBody2D

func _ready():
	state_machine.init(self)
	
func handle_movement(delta): 
	var direction = Input.get_axis("left", "right")
	if direction: velocity_component.move(delta, direction)
	else: velocity_component.stop(delta)


## Flip the nodes to face wherever the player is moving. 
func flip_nodes(): 
	if velocity.x > 0: sprite.flip_h = false 
	elif velocity.x < 0: sprite.flip_h = true 
		
@onready var heli_detector = $General/HeliDetector

func is_touching_helipod(): 
	if heli_detector.has_overlapping_areas(): return true
	else: return false






