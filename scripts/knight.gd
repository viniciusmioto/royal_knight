extends CharacterBody2D
class_name Knight

@onready var fruit = $"../Fruit"
@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 130
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


# Define the predefined positions
var predefined_positions = [
	Vector2(-26, 56),
	Vector2(-10, 56),
	Vector2(38, 72),
	Vector2(118, 56),
]

func randomize_position():
	var index = randi() % predefined_positions.size()
	position = predefined_positions[index]
	
	
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

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip and Animate sprite
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
			if direction > 0:
				animated_sprite.flip_h = false
			if direction < 0:
				animated_sprite.flip_h = true
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
