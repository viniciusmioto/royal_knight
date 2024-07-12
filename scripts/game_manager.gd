extends Node

signal game_started
signal fruit_collected
signal knight_fall

var is_game_started : bool = false
var is_game_ended : bool = false
var score : int = 0
var deaths: int = 0


func _ready():
	game_started.connect(_on_game_started)
	fruit_collected.connect(_on_fruit_collected)
	knight_fall.connect(_on_knight_fall)


func _on_game_started():
	is_game_started = true
	is_game_ended = false
	
	score = 0


func _on_fruit_collected():
	score += 1
	#print("score: ", score)


func _on_knight_fall():
	is_game_ended = true
	deaths += 1
	#print("deaths: ", deaths)
	
