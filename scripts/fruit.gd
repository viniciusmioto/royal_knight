extends Area2D
class_name Fruit

@onready var animation_player = $AnimationPlayer

# Define the predefined positions
#var predefined_positions = [
	#Vector2(53, 48),
	#Vector2(-10, 28),
	#Vector2(-90, 6),
	#Vector2(12, 37),
	#Vector2(70, 30)
#]

func _ready():
	#randomize_position()
	pass

func _on_body_entered(_body):
	animation_player.play("target_animation")
	GameManager.fruit_collected.emit()
	#randomize_position()
#
#func randomize_position():
	#var index = randi() % predefined_positions.size()
	#position = predefined_positions[index]
