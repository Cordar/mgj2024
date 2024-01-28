extends Control

@export var page: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in $memes.get_children():
		if (Globals.memes_unlocked[item.meme]):
			item.set_modulate(Color(1,1,1,1))
		else:
			item.set_modulate(Color(1,1,1,0.1))


func _on_go_back_button_pressed():
	$AudioStreamPlayer2D.stream = load("res://assets/sounds/SFX1/click.wav")
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	change_to_scene("res://scenes/UI/start_menu.tscn")


func _on_next_page_button_pressed():
	$AudioStreamPlayer2D.stream = load("res://assets/sounds/SFX1/click.wav")
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	if page < 2:
		change_to_scene(get_scene_path(page + 1))
	else:
		change_to_scene(get_scene_path(0))

func _on_previous_page_button_pressed():
	$AudioStreamPlayer2D.stream = load("res://assets/sounds/SFX1/click.wav")
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	if page > 0:
		change_to_scene(get_scene_path(page - 1))
	else:
		change_to_scene(get_scene_path(2))
	
func get_scene_path(pageNumber: int) -> String:
	return "res://scenes/UI/album" + str(pageNumber) + ".tscn";

func change_to_scene(path: String):
	get_tree().change_scene_to_file(path)

