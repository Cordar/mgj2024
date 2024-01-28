extends Node2D

@export var labelMessage: String;
@export var unlockMeme: String = "";

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = labelMessage


func _on_area_2d_body_entered(body:Node2D):
	if body.name=="Player":
		$Label.show()
		if unlockMeme != "":
			Globals.unlock_meme(unlockMeme)

func reset():
	$Label.hide()