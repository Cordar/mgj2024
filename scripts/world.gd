extends Node2D
@export var deathCounterLabel: Label

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready():
	setDeathsLabel()


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
