extends Level

@onready var player = $Player
@onready var helipod = $Helipod

func init(enter_params: EnterParams = null):
	if enter_params: 
		player.init(enter_params.player_state, enter_params.player_pos)
		if enter_params.player_state == 'flying': 
			helipod.init('carrying')
