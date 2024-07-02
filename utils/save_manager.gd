extends Node


const SAVE_PATH: String = 'user://savegame.bin'
const SAVE_PASS: String = 'password'


func get_file(is_write: bool):
	var save_file: FileAccess
	var password: String = SAVE_PASS
	
	if OS.get_name() == 'Android' or OS.get_name() == ' iOS':
		password = OS.get_unique_id()
	
	if is_write:
		save_file = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.WRITE, password) 
	else: 
		if not FileAccess.file_exists(SAVE_PATH):
			return
		save_file = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.READ, password) 
	
	return save_file
		
		


func load_game():
	var save_file = get_file(false) 
	
	if not save_file: return
	
	#var current_line = save_file.get_line()
	#print(current_line)
	
	while not save_file.eof_reached():
		#var current_line = JSON.parse_string(save_file.get_line())
		var current_line = save_file.get_line()
		print(current_line)


	
	save_file.close()


func save_game():
	var save_file = get_file(true) 
	
	
	var data: Dictionary = {
		'current_day': 'this is the current day',
		#'player_health': 50
	}
	
	# TODO: Save all manipulated tiles in game_manager.
	
	#for d in data:
		#save_file.store_line(JSON.stringify(d))
	
	save_file.store_line(JSON.stringify(data))
	save_file.close()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('save'):
		save_game()
	
	elif event.is_action_pressed('load'):
		load_game()
