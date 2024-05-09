extends Camera2D

@export var world: World

func _ready() -> void:
	# Set the limits of the camera. 
	if world: 
		# NOTE: Tiles are 16 wide. 
		var world_offset = 5*16
		
		# The islands extend the right side of the world because 
		# of their size. The widest island is 23. 
		var island_offset = 23*16 
		
		limit_left = 0 - (world.world_width/2)*16 - world_offset
		limit_right = 0 + (world.world_width/2)*16 + world_offset + island_offset
		limit_top = 0 - world.world_height*16 - world_offset
		
