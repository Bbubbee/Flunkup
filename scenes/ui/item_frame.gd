extends PanelContainer

@onready var item_icon = %ItemIcon
@onready var selected_texture = $SelectedTexture
@onready var amount_label: Label = $MarginContainer/AmountLabel

var current_item: InventoryItem 

func _ready():
	selected_texture.visible = false
	amount_label.hide()
	
func show_item(inv_item: InventoryItem): 
	amount_label.show()
	current_item = inv_item
	item_icon.texture = inv_item.item.icon 
	amount_label.text = str(inv_item.amount)
	
func select_slot(should_show: bool):
	if should_show and current_item: 
		Events.set_held_item.emit(current_item.item)
	selected_texture.visible = should_show
