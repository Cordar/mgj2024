extends Control


func _on_start_button_pressed():
	Globals.unlock_meme(Globals.Meme.Monkey)
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_album_button_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/album.tscn")
