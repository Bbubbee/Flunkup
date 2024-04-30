class_name Inventory


var content: Array[Crop] = []

# TODO: Change crop to Item.

func add_item(item: Crop):
	content.append(item) 

func remove_item(item: Crop): 
	content.erase(item) 

func get_items() -> Array[Crop]:
	return content
