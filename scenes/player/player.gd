extends CharacterBody2D
class_name Player

# General. 
@onready var sprite: Sprite2D = $General/Sprite

# Components.
@onready var velocity_component: PlayerVelocityComponent = $Components/VelocityComponent
@onready var jump_component: JumpComponent = $Components/JumpComponent
@onready var state_machine: PlayerStateMachine = $StateMachine

# Test crops for inventory. 
const WHEAT = preload("res://resources/crops/wheat.tres")
const CARROT = preload("res://resources/crops/carrot.tres")

@export var helipod: CharacterBody2D

var inventory: Inventory = Inventory.new() 
@onready var hot_bar = $UIRoot/HotBar

@onready var concurrent_animator: AnimationPlayer = $General/ConcurrentAnimator
@onready var state_machine_2: PlayerStateMachine = $StateMachine2

func init(state: String = '', pos: Vector2 = Vector2.ZERO):
	
	if state: state_machine.force_transition(state) 
	if pos: global_position = pos
	#global_position 

func _ready():
	# Connect signals.
	Events.set_mode.connect(set_mode)
	Events.set_held_item.connect(_on_set_held_item)
	Events.picked_up_item.connect(_on_picked_up_item)
	
	# Inventory test. 
	inventory.add_item(CARROT)
	inventory.add_item(CARROT)
	inventory.add_item(WHEAT)
	inventory.add_item(WHEAT)
	inventory.add_item(WHEAT)
	
	hot_bar.refresh_hotbar(inventory)
	
	state_machine.init(self)
	state_machine_2.init(self)
	
	init()


# Picked up a new item. Add it to the inventory. 
func _on_picked_up_item(item: Item):
	inventory.add_item(item)
	hot_bar.refresh_hotbar(inventory)

# The item the player is currently holding. 
var held_item: Item
func _on_set_held_item(item: Item):
	held_item = item

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

func set_mode(active: bool):
	can_plant = active

var can_plant: bool = false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and can_plant and held_item:
		Events.plant_on_tile.emit(self.get_global_mouse_position(), held_item)


func _on_hurtbox_im_hit() -> void:
	state_machine_2.force_transition('hurt')



