extends Control


func _on_go_back_menu_pressed():
	Globals.unlock_meme(Globals.memeFireGirl)
	get_tree().change_scene_to_file("res://scenes/UI/start_menu.tscn")
