extends TextureProgressBar

func _ready():
	value = max_value

func _physics_process(delta):
	auto_replenish(delta)
	
var is_active: bool = false

# Automatically replenish progress when it is not active. 
func auto_replenish(change: float):
	if not is_active: replenish(0.5)

func deplete(change: float): 
	value -= change

func replenish(change: float): 
	value += change
