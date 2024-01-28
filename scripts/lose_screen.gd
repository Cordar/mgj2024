extends TextureRect


func _on_animation_player_animation_finished(anim_name:StringName):
	if anim_name=="booggieboogie":
		queue_free()
