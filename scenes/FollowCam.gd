extends Camera2D

@export var tilemap : TileMap

func _ready():
	pass
#	var map_rect = tilemap.get_used_rect() # get the size of the tilemap
#	var tile_size = tilemap.cell_quadrant_size # get the size of each cell
#	var upper_left_corner = map_rect.position * tile_size
#	var lower_right_corner = (map_rect.position + map_rect.size) * tile_size
#	limit_left = tilemap.position.x + upper_left_corner.x
#	limit_top = tilemap.position.y + upper_left_corner.y
#	limit_right = tilemap.position.x + lower_right_corner.x
#	limit_bottom = tilemap.position.y + lower_right_corner.y
#	print("limit_left -> ", limit_left)
#	print("limit_top -> ", limit_top)
#	print("limit_right -> ", limit_right)
#	print("limit_bottom -> ", limit_bottom)
	
