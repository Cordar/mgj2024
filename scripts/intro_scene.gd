extends Control
@onready var textLabel = $RichTextLabel

const TEXT_SPEED = 0.03

func _on_animation_player_animation_finished(anim_name:StringName):
	get_tree().change_scene_to_file("res://scenes/world.tscn")



func delayText(text: String):
	$AudioStreamPlayer2D.play()
	for i in range(0,text.length()):
		await get_tree().create_timer(TEXT_SPEED).timeout
		textLabel.text += text[i]
	$AudioStreamPlayer2D.stop()

func cleanText():
	textLabel.text = ''


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")
