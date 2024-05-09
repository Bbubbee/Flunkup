extends Sprite2D

@onready var area: Area2D = $Area

var is_mouse_over: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and is_mouse_over: 
		print('go here')
		Events.position_helipod.emit(self.global_position, self) 
	
	
func mine(): 
	queue_free()


func _on_area_mouse_entered() -> void:
	is_mouse_over = true 


func _on_area_mouse_exited() -> void:
	is_mouse_over = false
