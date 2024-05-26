extends Level

@onready var player = $Player
@onready var helipod = $Helipod

func init(enter_params: EnterParams = null):
	if enter_params: 
		player.init(enter_params.player_state, enter_params.player_pos)
		if enter_params.player_state == 'flying': 
			helipod.init('carrying')


func _on_player_detector_body_entered(_body: Node2D) -> void:
	var enter_params = EnterParams.new() 
	enter_params.player_pos = Vector2(player.global_position.x, -1470)
	enter_params.player_state = "flying"
	
	change_wilds_level.emit(Vector2i.DOWN, enter_params)
