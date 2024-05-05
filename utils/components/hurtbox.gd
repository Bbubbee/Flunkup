extends Area2D
class_name Hurtbox

# Rememeber to:
#	- Set masks => these are the colliders that can hurt you. 
#   - Attach a health component to this node.  

#@export var health_component: HealthComponent

signal im_hit 

func _on_hitbox_entered(hitbox: Hitbox) -> void:
	if not hitbox: return 
	
	im_hit.emit() 
	#if not hitbox: return 
	
	#health_component.take_damage(hitbox)

func disable():
	monitorable = false 
	monitoring = false
		

