class_name Inventory


var content: Array[Item] = []

var content_new: Array[InventoryItem] = []


func add_item(item: Item):
	content.append(item) 
	
	# Check if item exists in inventory. 
	var name_check: String = item.name
	for i in content_new:
		if i.item.name == name_check:
			i.amount += 1 
			return
	
	# Add inventory item to inventory. 
	var inv_item = InventoryItem.new()
	inv_item.init(item, 1)
	content_new.append(inv_item)

	

func remove_item(item: Item): 
	content.erase(item) 

func get_items() -> Array[Item]:
	return content

func get_items_new() -> Array[InventoryItem]:
	return content_new
