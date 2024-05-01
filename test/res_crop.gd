extends Sprite2D


@export var crop: Crop

var age: int = 0

func init(new_crop: Crop):
	crop = new_crop
	texture = new_crop.sprite_sheet
	
	
func _ready():
	
	Events.increase_day.connect(_on_increase_day)


func _on_increase_day():
	age += 1
	
	if age > crop.days_until_adult/4: 
		age = 0 
		frame = min(frame + 1, 3)

