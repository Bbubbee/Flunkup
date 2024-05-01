extends Node


signal position_helipod(tile_pos: Vector2, original_tile_pos: Vector2i)
signal player_touched_heli(hold: bool)

signal process_tile(tile_pos: Vector2)
signal plant_on_tile(pos: Vector2, crop: Item)

signal set_mode(active: bool)

signal increase_day

signal set_held_item(item: Item)

 
