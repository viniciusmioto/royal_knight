extends Area2D
class_name KillZone
	
func _on_body_entered(_body):
	GameManager.knight_fall.emit()
	_body.randomize_position()
