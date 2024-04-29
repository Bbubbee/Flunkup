extends TextureProgressBar

func _ready():
	value = max_value

func _physics_process(_delta: float):
	auto_replenish()
	
var is_active: bool = false

# Automatically replenish progress when it is not active. 
func auto_replenish():
	if not is_active: replenish(2)

func deplete(change: float): 
	value -= change

func replenish(change: float): 
	value += change
