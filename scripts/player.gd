extends CharacterBody2D
@onready var animations = $AnimationPlayer
@onready var playerSprite = $Sprite2D


const SPEED = 190.0
const JUMP_VELOCITY = -510.0

var previousPosition = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass
	
func updateAnimation():
	if position.y < previousPosition.y: 
		animations.play("jump")
	elif position.y > previousPosition.y: 
		animations.play("fall_normal")
		print_debug("falll")
	elif velocity.x != 0:
		animations.play("run")
	else:
		animations.play("idle")
	
	if Input.is_action_just_pressed("ui_left"):
		playerSprite.flip_h=true
	elif Input.is_action_just_pressed("ui_right"):
		playerSprite.flip_h=false

func _physics_process(delta):
	updateAnimation()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	previousPosition = position

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
