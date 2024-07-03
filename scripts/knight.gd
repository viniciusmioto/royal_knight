extends CharacterBody2D
class_name Knight

@onready var fruit = $"../Fruit"
@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 130
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var knight_X = self.position.x
var knight_Y = self.position.y

func _ready():
	GameManager.game_started.connect(_on_game_started)
	GameManager.knight_fall.connect(_on_knight_fall)

func _on_game_started():
	set_physics_process(true)
	set_process_input(true)

func _on_knight_fall():
	set_process_input(false)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle discrete left and right movement.
	if Input.is_action_just_pressed("move_left"):
		velocity.x = -SPEED
	elif Input.is_action_just_pressed("move_right"):
		velocity.x = SPEED
	elif Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		velocity.x = 0

	# Flip and animate sprite.
	if is_on_floor():
		if velocity.x == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
			if velocity.x > 0:
				animated_sprite.flip_h = false
			if velocity.x < 0:
				animated_sprite.flip_h = true
	else:
		animated_sprite.play("jump")
		
	move_and_slide()
