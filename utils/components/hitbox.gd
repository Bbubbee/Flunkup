extends Area2D
class_name Hitbox

"""
Remember: 
	- Set layers => These are the colliders that you can hit. 
	- Set masks  => This is if you want your hitbox to detect something and 
		act accordingly. 
		
		For example, you want a projectile to queue_free() when it hits 
		something. Set your mask to detect walls or enemies, then 
		connect the area_entered() signal to your parent node, then call 
		queue_free() when the signal fires. 
"""

@export var damage: float = 1.0
@export var knockback: float = 100.0
var direction
	# The direction in which actors will be knocked back.
	
func disable(): 
	monitorable = false 
	monitoring = false


