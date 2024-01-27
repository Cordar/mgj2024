extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for item in $memes.get_children():
		if (Globals.is_meme_found[item.meme] == true):
			item.set_modulate(Color(1,1,1,1))
		else:
			item.set_modulate(Color(1,1,1,0.5))


func _on_go_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/start_menu.tscn")
