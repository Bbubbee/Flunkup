extends Label

var current_day: int = 1

func _ready() -> void:
	text = str(GameManager.current_day)
	Events.increase_day.connect(_on_increase_day)

func _on_increase_day(day: int):
	text = str(day)
	

