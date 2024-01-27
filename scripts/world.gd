extends Node2D
@export var deathCounterLabel: Label

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready():
	setDeathsLabel()
	if (Globals.levelCheckpoint == 1):
		load_level1()
	$Player.position = Globals.lastCheckpoint


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_shitmeter_shit_meter_is_full():
	die()

func die():
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout
	get_tree().paused = false
	get_tree().reload_current_scene()
	Globals.deaths += 1
	setDeathsLabel()

func setDeathsLabel():
	deathCounterLabel.text = str(Globals.deaths)


func _on_shitmeter_half_full():
	$Player.needsToiletNow = true


func _on_player_died():
	die()

func load_level1():
	$Level.queue_free()
	var newLevel = load("res://scenes/level_1.tscn")
	var newLevel_instance = newLevel.instantiate()
	newLevel_instance.set_name("Level")
	add_child(newLevel_instance)

func go_to_next_level():
	load_level1()
	$Player.position = Vector2(12, -281)
	Globals.levelCheckpoint = 1
	Globals.lastCheckpoint = $Player.position
	Globals.save_game()


func _on_area_2d_body_entered(body:Node2D):
	go_to_next_level()
	$Area2D.queue_free()
