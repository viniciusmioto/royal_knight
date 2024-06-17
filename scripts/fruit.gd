extends Area2D
class_name Fruit

@onready var animation_player = $AnimationPlayer


func _ready():
	pass

func _on_body_entered(_body):
	animation_player.play("target_animation")
	GameManager.fruit_collected.emit()
