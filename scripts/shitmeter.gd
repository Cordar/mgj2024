extends Control

var oldAmount = 0;
var amount = 0;
@export var increaseRate = 10;

@export var threshhold1: int = 25;
@export var threshhold2: int = 50;
@export var threshhold3: int = 75;
@export var threshhold4: int = 100;

@export var image1: Texture2D;
@export var image2: Texture2D;
@export var image3: Texture2D;
@export var image4: Texture2D;

signal full()
signal half_full()


func _process(_delta):
	if amount > threshhold1 and amount <= threshhold2:
		$Image.texture = image2
	elif amount > threshhold2 and amount <= threshhold3:
		$Image.texture = image3
	elif amount > threshhold3 and amount <= threshhold4:
		$Image.texture = image4
	elif amount > threshhold4:
		full.emit()
		return
	else:
		$Image.texture = image1
	amount += increaseRate * _delta

func setAmount(_amount: int) -> void:
	oldAmount = amount
	amount = _amount

	if oldAmount < threshhold2 and amount >= threshhold2:
		half_full.emit()
	
	if oldAmount < threshhold4 and amount >= threshhold4:
		full.emit()

func reset() -> void:
	amount = 0
	$Image.texture = image1


