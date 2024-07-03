extends FeatureNode

@onready var fruit: Fruit = $playground/Fruit
@onready var knight: Knight = $playground/Knight

var dead = false
var score : int = 0
var x_dist
var y_dist


func _ready():
	GameManager.knight_fall.connect(_on_knight_fall)
	GameManager.fruit_collected.connect(_on_fruit_collected)
	GameManager.game_started.emit()   

func _on_knight_fall():
	dead = true

func _on_fruit_collected():
	score += 1

func dist(x, y):
	return x - y

func _process(_delta: float) -> void:
	x_dist = dist(knight.position.x, fruit.position.x)
	y_dist = dist(knight.position.y, fruit.position.y)

func set_fruit_position(i, j):
	fruit.position.x = i
	fruit.position.y = j

