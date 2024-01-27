extends Area2D


func _on_area_2d_body_entered(body:Node2D):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/UI/winscreen.tscn")
