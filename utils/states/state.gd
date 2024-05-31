extends Node
class_name State

signal transition  # Use me to transition states. 

var actor: CharacterBody2D  # Parent of this state. 

# Used if you want to retrive the name of a stet. 
var state_name: String = ''

## Note: You can't change states in the enter/exit function! 
## If you think a state might change in the enter/exit
## function, declare a variable in that state to check. 
func enter(_enter_params = null):
	pass
	
func exit():
	pass
	
func process(_delta: float):
	pass
	
func physics_process(_delta: float):
	pass
	
func on_input(_event: InputEvent): 
	pass


