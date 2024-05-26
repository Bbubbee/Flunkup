extends Sprite2D

@export var crop: Crop

# Used to increment the stages of growth for a crop (4 stages)
var stage_counter: int = 0
# Tracks the actual age of the crop. 
var age: int = 0 
var harvestable: bool = false

func init(new_crop: Item):
	crop = new_crop
	texture = new_crop.sprite_sheet
	
	
func _ready():
	Events.increase_day.connect(_on_increase_day)


func _on_increase_day():
	if harvestable: return
	stage_counter += 1
	
	# A crop has 4 sprites for stage of growth. 
	if stage_counter > roundi(float(crop.days_until_adult)/4.0):
		stage_counter = 0 
		frame = min(frame + 1, 3)
	
	age += 1 
	if age >= crop.days_until_adult-1: harvestable = true


const ITEM_DROP = preload("res://scenes/items/item_drop.tscn")


## If the crop is harvestable, and the helipod has passed throught it, harvest it. 
func _on_area_2d_body_entered(_body):
	if not harvestable: return 
	
	call_deferred('harvest')
	

func harvest(): 
	var root = get_tree().get_root()
	var item_drop = ITEM_DROP.instantiate()
	item_drop.global_position = global_position
	root.add_child(item_drop)
	item_drop.init(crop)
	queue_free()
