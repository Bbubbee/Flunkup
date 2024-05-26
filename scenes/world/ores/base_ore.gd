extends Sprite2D

@export var ore_type: Ore

@onready var area: Area2D = $Area
const ITEM_DROP = preload("res://scenes/items/item_drop.tscn")

var is_mouse_over: bool = false

var time_to_mine: int = 2

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and is_mouse_over:
		# Position helipod 2 tiles above ore. 
		var pos = Vector2(global_position.x, global_position.y - 16)
		 
		Events.position_helipod.emit(pos, self) 
	
	
func act_upon(): 
	time_to_mine -= 1 
	if time_to_mine <= 0: 
		var item_drop = ITEM_DROP.instantiate() 
		item_drop.global_position = self.global_position
		get_tree().get_root().add_child(item_drop) 
		item_drop.init(ore_type)
		queue_free()


# Checks if mouse is over crop. 

func _on_area_mouse_entered():
	is_mouse_over = true 

func _on_area_mouse_exited():
	is_mouse_over = false 
