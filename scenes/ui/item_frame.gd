extends PanelContainer

@onready var item_icon = %ItemIcon
@onready var selected_texture = $SelectedTexture

var current_item: Item 

func _ready():
	selected_texture.visible = false
	
func show_item(item: Item): 
	current_item = item
	item_icon.texture = item.icon 
	
func select_slot(should_show: bool):
	if should_show and current_item: 
		Events.set_held_item.emit(current_item)
	selected_texture.visible = should_show
