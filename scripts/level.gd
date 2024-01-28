extends Node2D


func reset():
	for i in get_children():
		if i.has_method("reset"):
			i.reset()
	for i in $TileMap.get_children():
		if i.has_method("reset"):
			i.reset()