extends FeatureNode

@onready var fruit: Fruit = $playground/Fruit
@onready var knight: Knight = $playground/Knight

var dead = false
var score : int = 0
var fruit_X
var fruit_Y
var knight_X
var knight_Y


func _ready():
	GameManager.knight_fall.connect(_on_knight_fall)
	GameManager.fruit_collected.connect(_on_fruit_collected)
	GameManager.game_started.emit()   
	
func _on_knight_fall():
	dead = true
	
func _on_fruit_collected():
	score += 1
	
	
func _process(_delta: float) -> void:
	fruit_X = fruit.position.x
	fruit_Y = fruit.position.y
	knight_X = knight.position.x
	knight_Y = knight.position.y
	
func set_fruit_position(i, j):
	fruit.position.x = i
	fruit.position.y = j

