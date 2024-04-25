extends State

func _ready():
	Events.position_helipod.connect(_on_position_helipod)
	

func physics_process(delta: float) -> void:
	actor.velocity_component.stop_freely(delta)
	actor.move_and_slide()


func on_input(event: InputEvent): 
	# Go to where the mouse was clicked. 
	if event.is_action_pressed('right_click'):
		transition.emit(self, 'move') 

# A tile has been pressed. Go to that tile. 
func _on_position_helipod(tile_pos: Vector2, original_tile_pos: Vector2i):
	var params = {'target': tile_pos, 'original_tile_pos': original_tile_pos}
	transition.emit(self, 'move', params)
