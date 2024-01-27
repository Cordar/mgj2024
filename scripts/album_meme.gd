extends TextureRect


@export var meme : String;

func _ready():
    var memeTexture = Globals.find_meme_texture(meme)
    set_texture(memeTexture)
