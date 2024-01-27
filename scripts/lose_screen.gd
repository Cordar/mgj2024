extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.deaths >= 5:
		Globals.unlock_meme("BlackFuneral")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name:StringName):
	print(anim_name)
	if anim_name=="booggieboogie":
		queue_free()
