extends PanelContainer

@onready var item_container = $MarginContainer/ItemContainer



func init(inventory: Inventory):
	var length = inventory.get_items().size()
	var i: int = 0
	
	for item in item_container.get_children():
		item.show_item(inventory.content[i]) 
		
		i += 1 
		
		# Stop populating the hot bar items once the end of the inventory is reached,
		# or the maximum number of items are reached.
		# The number of items shouldn't exceed the carry limit anyways. 
		if i >= length or i >= 12: break
		
	# Select the first slot. 
	item_container.get_child(0).select_slot(true)
	



func _input(event: InputEvent):
	var hotbar_slot_pressed: int = 0
	if event.is_action_pressed('1'):
		hotbar_slot_pressed = 1
	elif event.is_action_pressed('2'):
		hotbar_slot_pressed = 2	
	elif event.is_action_pressed('3'):
		hotbar_slot_pressed = 3	
	elif event.is_action_pressed('4'):
		hotbar_slot_pressed = 4	
	elif event.is_action_pressed('5'):
		hotbar_slot_pressed = 5	
	elif event.is_action_pressed('6'):
		hotbar_slot_pressed = 6	
	elif event.is_action_pressed('7'):
		hotbar_slot_pressed = 7	
	elif event.is_action_pressed('8'):
		hotbar_slot_pressed = 8	
	elif event.is_action_pressed('9'):
		hotbar_slot_pressed = 9	
	elif event.is_action_pressed('0'):
		hotbar_slot_pressed = 10	
	elif event.is_action_pressed('-'):
		hotbar_slot_pressed = 11	
	elif event.is_action_pressed('plus'):
		hotbar_slot_pressed = 12
	else: return 
	
	select_slot(hotbar_slot_pressed-1)


func select_slot(num: int):
	pass
	
	# Unselect all slots. 
	for item in item_container.get_children():
		item.select_slot(false)
	
	# Select the selected slot. 
	item_container.get_child(num).select_slot(true)

