extends Node


signal position_helipod(pos: Vector2, entity)
signal player_touched_heli(hold: bool)

signal process_tile(tile_pos: Vector2)
signal plant_on_tile(pos: Vector2, crop: Item)

signal set_mode(active: bool)

signal increase_day

signal set_held_item(item: Item)

signal picked_up_item(item: Item) 



 
