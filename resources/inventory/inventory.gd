class_name Inventory


var content_new: Array[InventoryItem] = []


func add_item(item: Item):
	# TODO: Optimise inventory and hotbar relationship. 
	
	# Add item amount if it exists in the inventory. 
	var name_check: String = item.name
	for i in content_new:
		if i.item.name == name_check:
			i.amount += 1 
			return
	
	# Add new item into the inventory.
	var inv_item = InventoryItem.new()
	inv_item.init(item, 1)
	content_new.append(inv_item)


func remove_item(item: InventoryItem): 
	content_new.erase(item) 


func get_items_new() -> Array[InventoryItem]:
	return content_new
