extends Area2D

@onready var score_canvas = %ScoreCanvas
@onready var animation_player = $AnimationPlayer

func _on_body_entered(_body):
	score_canvas.add_point()
	animation_player.play("pickup")
