extends Node2D
@export var deathCounterLabel: Label

const poopedSound = preload("res://assets/sounds/Voces/me_cague.wav")

const lose_screen = preload("res://scenes/UI/lose_screen.tscn")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready():
	setDeathsLabel()
	if (Globals.levelCheckpoint == 1):
		load_level1()
	$Player.position = Globals.lastCheckpoint
	$AudioStreamPlayer2D.play(Globals.musicProgress)

var playingShitThing = false

func _on_shitmeter_shit_meter_is_full():
	if playingShitThing:
		return
	playingShitThing = true
	Globals.unlock_meme(Globals.memePoopedPants)
	playSound(poopedSound)
	await $EffectsPlayer.finished
	die()

func die():
	get_tree().paused = true
	await get_tree().create_timer(0.5).timeout
	
	var lose_screen_instance = lose_screen.instantiate()
	lose_screen_instance.set_name("lose_screen")
	$CanvasLayer.add_child(lose_screen_instance)
	await get_tree().create_timer(2.5).timeout
	updateDeathCounter()
	Globals.musicProgress = $AudioStreamPlayer2D.get_playback_position() 
	$Player.position = Globals.lastCheckpoint
	$Player.dead = false
	$Level.reset()
	get_tree().paused = false
	await get_tree().create_timer(1.0).timeout
	$Player.invincible = false
	$CanvasLayer/HUD/Shitmeter.reset()
	playingShitThing = false
	

func updateDeathCounter():
	Globals.deaths += 1
	if Globals.deaths >= 10:
		Globals.unlock_meme(Globals.memeThisIsFine)
	if Globals.deaths >= 20:
		Globals.unlock_meme(Globals.memeBlackFuneral)
	if Globals.deaths >= 50:
		Globals.unlock_meme(Globals.memeHereWeGoAgain)
	setDeathsLabel()
	
func setDeathsLabel():
	deathCounterLabel.text = str(Globals.deaths)


func _on_shitmeter_half_full():
	$Player.needsToiletNow = true


func _on_player_died():
	die()

func load_level1():
	if ($Level != null):
		$Level.call_deferred("free")
	var newLevel_instance = Globals.level1Scene.call_deferred("instantiate")
	newLevel_instance.name = "Level"
	add_child(newLevel_instance, true)

func load_level0():
	if ($Level != null):
		$Level.call_deferred("free")
	var newLevel_instance = Globals.level0Scene.call_deferred("instantiate")
	newLevel_instance.name = "Level"
	add_child(newLevel_instance, true)

func go_to_next_level():
	load_level1()
	$Player.position = Vector2(12, -281)
	Globals.levelCheckpoint = 1
	Globals.lastCheckpoint = $Player.position
	Globals.save_game()


func _on_area_2d_body_entered(body:Node2D):
	if body.name == "Player":
		go_to_next_level()
		$Area2D.queue_free()

func playSound(sound):
	$EffectsPlayer.stream = sound
	$EffectsPlayer.play()
