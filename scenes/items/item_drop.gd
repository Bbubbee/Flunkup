extends RigidBody2D

@export var item: Item
@onready var sprite = $Sprite

var tween: Tween

func init(new_item: Item):
	item = new_item 
	sprite.texture = item.icon
	
func _ready():
	# Spinning animation. 
	tween = get_tree().create_tween()
	tween.tween_property(sprite, 'scale', Vector2(-1, 1), 2).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(sprite, 'scale', Vector2(1, 1), 2).set_ease(Tween.EASE_IN_OUT)
	tween.set_loops()

func spawn(): 
	pass
	
	# Bounce in random upwards direction. 


func _on_player_detector_body_entered(_body):
	tween.stop()
	queue_free()
