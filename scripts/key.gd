extends Sprite2D


@export var keyId: int;


func _on_area_2d_body_entered(body:Node2D):
	if body.name == "Player":
		body.addKey(keyId)
		queue_free()
