extends Node

enum Meme {
	Monkey,
	Cow,
	InfernalGirl,
}

var is_meme_found = {
	Meme.Monkey: false,
	Meme.Cow: false,
	Meme.InfernalGirl: false,
};
var levelCheckpoint: int = 0;
var lastCheckpoint: Vector2 = Vector2(0, 0);

var deaths: int = 0;

func _ready():
	load_game();

func unlock_meme(meme: Meme) -> void:
	if is_meme_found[meme]:
		return;
	is_meme_found[meme] = true;
	save_game();
	var canvas_layer = CanvasLayer.new()
	canvas_layer.set_name("canvas_layer")
	add_child(canvas_layer)
	var meme_popup = load("res://scenes/UI/meme_popup.tscn")
	var meme_popup_instance = meme_popup.instantiate()
	meme_popup_instance.set_name("meme_popup")
	canvas_layer.add_child(meme_popup_instance)

# Note: This can be called from anywhere inside the tree. This function is
# path independent.
func save_game():
	var save_game_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	# JSON provides a static method to serialized JSON string.
	var json_string = JSON.stringify(
		{
			"is_meme_found": is_meme_found,
			"last_checkpoint": {
			"x": lastCheckpoint.x,
			"y": lastCheckpoint.y,
			},
			"level_checkpoint": levelCheckpoint,
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
		var loaded_is_meme_found = load_data["is_meme_found"]
		for key in loaded_is_meme_found:
			var value = loaded_is_meme_found[key]
			is_meme_found[int(key)] = value

		# Load checkpoint data
		var loaded_last_checkpoint = load_data["last_checkpoint"]
		lastCheckpoint = Vector2(loaded_last_checkpoint["x"], loaded_last_checkpoint["y"])

		# Load level checkpoint data
		levelCheckpoint = load_data["level_checkpoint"]

func reset_game():
	is_meme_found = {
		Meme.Monkey: false,
		Meme.Cow: false,
		Meme.InfernalGirl: false,
	};
	lastCheckpoint = Vector2(0, 0);
	levelCheckpoint = 0;
	save_game();