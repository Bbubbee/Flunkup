extends Label

var current_day: int = 1

func _ready() -> void:
	text = str(current_day)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("increase_day"):
		current_day += 1 
		text = str(current_day)
		
		Events.increase_day.emit()
