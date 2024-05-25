extends Level
class_name BottomLevel

@onready var player: Player = $Player
@onready var helipod: CharacterBody2D = $Helipod



func init(enter_params: EnterParams = null):
	if enter_params: 
		player.init(enter_params.player_state, enter_params.player_pos)
		if enter_params.player_state == 'flying': 
			helipod.init('carrying')

func _on_transition_area_body_entered(_body):
	var enter_params = EnterParams.new() 
	enter_params.player_pos = Vector2(player.global_position.x, 0-100)
	enter_params.player_state = 'flying'
	go_up_level.emit(enter_params)

