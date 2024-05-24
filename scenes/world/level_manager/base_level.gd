extends Node2D
class_name Level

signal change_level(level_path: String, enter_params: EnterParams)
signal go_up_level(enter_params: EnterParams)
signal go_down_level(enter_params: EnterParams) 


func init(enter_params: EnterParams = null): 
	if enter_params: 
		print("Hey! I have enter params")
