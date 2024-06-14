extends FeatureNode

@onready var fruit: Fruit = $playground/Fruit


var dead = false
var score : int = 0
var fruit_X = fruit.position.x
var fruit_Y = fruit.position.y


func _ready():
	GameManager.knight_fall.connect(_on_knight_fall)
	GameManager.fruit_collected.connect(_on_fruit_collected)
	GameManager.game_started.emit()
	
	
func _on_knight_fall():
	dead = true
	
func _on_fruit_collected():
	score += 1
	
	
func _process(delta: float) -> void:
	fruit_X = fruit.position.x
	fruit_Y = fruit.position.y
	
	

