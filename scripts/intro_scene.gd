extends Control
@onready var textLabel = $RichTextLabel

func _on_animation_player_animation_finished(anim_name:StringName):
	get_tree().change_scene_to_file("res://scenes/world.tscn")



func delayText(text: String):
	for i in range(0,text.length()):
		await get_tree().create_timer(0.1).timeout
		textLabel.text += text[i]

func cleanText():
	textLabel.text = ''
