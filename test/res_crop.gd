extends Sprite2D


@export var crop: Crop

var age: int = 0

func _ready():
	texture.set_region(crop.atlas_coord)
	
	Events.increase_day.connect(_on_increase_day)


func _on_increase_day():
	age += 1
	
	if age > 5: 
		age = 0 
		frame = min(frame + 1, 3)

