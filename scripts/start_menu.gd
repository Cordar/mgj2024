extends Control


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/intro_scene.tscn")


func _on_album_button_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/album0.tscn")


func _on_reset_save_data_pressed():
	Globals.reset_game()
	
