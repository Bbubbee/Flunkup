class_name InventoryItem 

"""
About: 
	The way the inventory keeps track of items. Not to be confused with a normal Item. 
"""

# TODO: Add a item limit. 


var item: Item 
var amount: int 

func init(i: Item, amt: int):
	self.item = i
	self.amount = amt
