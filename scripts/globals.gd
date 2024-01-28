extends Node

var memeMonkey = "Monkey";
var memeBlackFuneral = "BlackFuneral";
var memeHereWeGoAgain = "HereWeGoAgain";
var memeThisIsFine = "ThisIsFine";
var memeBeen84Years = "Been84Years";
var memeBaxaApproves = "BaxaApproves";
var memeTheWhat = "TheWhat";
var memeFireGirl = "FireGirl";
var memeGreatThinker = "GreatThinker";
var memePoopedPants = "PoopedPants";


var memes_unlocked;
var levelCheckpoint: int;
var lastCheckpoint: Vector2;

var deaths: int = 0;

var musicProgress: int = 0;

var playedTime: int = 0;

const level0Scene = preload("res://scenes/level_0.tscn")
const level1Scene = preload("res://scenes/level_1.tscn")

const memeSound = preload("res://assets/sounds/SFX2/coger_meme.wav")

var audioPlayer2D;

func _ready():
	initVariables();
	load_game();
	audioPlayer2D = AudioStreamPlayer2D.new()
	add_child(audioPlayer2D)

func _process(delta):
	playedTime += delta;
	if playedTime > 84:
		unlock_meme(memeBeen84Years);

func find_meme_texture(meme: String) -> Texture:
	var pngTexture = load("res://assets/images/memes/" + str(meme) + ".png")
	if pngTexture == null:
		var jpgTexture = load("res://assets/images/memes/" + str(meme) + ".jpg")
		if jpgTexture == null:
			var webpTexture = load("res://assets/images/memes/" + str(meme) + ".webp")
			if webpTexture == null:
				print("Meme texture not found")
				return null;
			else:
				return webpTexture
		else:
			return jpgTexture
	else:
		return pngTexture

func unlock_meme(meme: String) -> void:
	if not memes_unlocked.has(meme):
		print("Meme not found")
		return;
	if memes_unlocked[meme]:
		print("Meme already unlocked")
		return;
	memes_unlocked[meme] = true;
	save_game();
	var canvas_layer = CanvasLayer.new()
	canvas_layer.set_name("canvas_layer")
	add_child(canvas_layer)
	var meme_popup = load("res://scenes/UI/meme_popup.tscn")
	var meme_popup_instance = meme_popup.instantiate()
	meme_popup_instance.set_name("meme_popup")
	var meme_texture = find_meme_texture(meme)
	if meme_texture == null:
		print("Meme texture not found")
		return;
	meme_popup_instance.set("texture", meme_texture)
	canvas_layer.add_child(meme_popup_instance)
	audioPlayer2D.stream = memeSound
	audioPlayer2D.play()

# Note: This can be called from anywhere inside the tree. This function is
# path independent.
func save_game():
	if not FileAccess.file_exists("user://savegame.save"):
		reset_game()

	var save_game_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	# JSON provides a static method to serialized JSON string.
	var json_string = JSON.stringify(
		{
			"memes_unlocked": memes_unlocked,
			"last_checkpoint": {
			"x": lastCheckpoint.x,
			"y": lastCheckpoint.y,
			},
			"level_checkpoint": levelCheckpoint,
			"played_time": playedTime,
		}
	)

	# Store the save dictionary as a new line in the save file.
	save_game_file.store_line(json_string)

# Note: This can be called from anywhere inside the tree. This function
# is path independent.
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_game_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game_file.get_position() < save_game_file.get_length():
		var json_string = save_game_file.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var load_data = json.get_data()

		# Load meme data
		var loaded_memes_unlocked = load_data["memes_unlocked"]
		for key in loaded_memes_unlocked:
			var value = loaded_memes_unlocked[key]
			memes_unlocked[key] = value

		# Load checkpoint data
		var loaded_last_checkpoint = load_data["last_checkpoint"]
		lastCheckpoint = Vector2(loaded_last_checkpoint["x"], loaded_last_checkpoint["y"])

		# Load level checkpoint data
		levelCheckpoint = load_data["level_checkpoint"]

		# Load played time
		playedTime = load_data["played_time"]

func initVariables():
	memes_unlocked = {
		memeMonkey: false,
		memeBlackFuneral: false,
		memeHereWeGoAgain: false,
		memeThisIsFine: false,
		memeBeen84Years: false,
		memeBaxaApproves: false,
		memeTheWhat: false,
		memeFireGirl: false,
		memeGreatThinker: false,
		memePoopedPants: false,
	};
	lastCheckpoint = Vector2(-476, -780);
	levelCheckpoint = 0;

func reset_game():
	initVariables();
	save_game();
