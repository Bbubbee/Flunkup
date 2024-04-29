extends Sprite2D


@export var crop: Crop

func _ready():
	texture.set_region(crop.atlas_coord)

