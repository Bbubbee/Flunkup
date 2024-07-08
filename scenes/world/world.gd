extends Level
class_name BottomLevel

@onready var player: Player = $Player
@onready var helipod: CharacterBody2D = $Helipod
@onready var player_camera = $PlayerCamera
@onready var temp_tilemap: TileMap = $TempTilemap

func _ready():
	pass

func init(enter_params: EnterParams = null):
	if enter_params: 
		player.init(enter_params.player_state, enter_params.player_pos)
		helipod.init(enter_params.player_state)

func _on_transition_area_body_entered(_body):
	var enter_params = EnterParams.new() 
	enter_params.player_pos = Vector2(player.global_position.x, 0+100)
	enter_params.player_state = 'flying'
	change_wilds_level.emit(Vector2i.UP, enter_params)

