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

func unlock_meme(meme: Meme) -> void:
	is_meme_found[meme] = true;