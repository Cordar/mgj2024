extends Node2D


func _on_area_2d_body_entered(body:Node2D):
	if body.name == "Player":
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.15).timeout
		body.die()
