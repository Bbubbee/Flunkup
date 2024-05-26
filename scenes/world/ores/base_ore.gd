extends Sprite2D

@onready var area: Area2D = $Area

var is_mouse_over: bool = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and is_mouse_over:
		# Position helipod 2 tiles above ore. 
		var pos = Vector2(global_position.x, global_position.y - 16)
		 
		Events.position_helipod.emit(pos, self) 
	
	
func act_upon(): 
	queue_free()


# Checks if mouse is over crop. 

func _on_area_mouse_entered():
	is_mouse_over = true 

func _on_area_mouse_exited():
	is_mouse_over = false 
