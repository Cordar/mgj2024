extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for item in $memes.get_children():
		print(item);
		print(item.get("Meme"));
		if (Globals.is_meme_found[item.Meme] == true):
			item.set_modulate(Color(1,1,1,1))
		else:
			item.set_modulate(Color(1,1,1,0.5))
