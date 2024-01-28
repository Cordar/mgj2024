extends Node2D


func _on_area_2d_body_entered(body:Node2D):
	if body.name == "Player":
		$Sprite2D.hide()

func reset():
	$Sprite2D.show()
