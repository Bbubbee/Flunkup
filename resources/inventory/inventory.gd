class_name Inventory


var content: Array[Item] = []

# TODO: Change crop to Item.

func add_item(item: Item):
	content.append(item) 

func remove_item(item: Item): 
	content.erase(item) 

func get_items() -> Array[Item]:
	return content
