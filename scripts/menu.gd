extends Control

func _ready():
	# Connect the "pressed" signal of the Play and Quit buttons to their respective handlers
	$MarginContainer/VBoxContainer/Play.connect("pressed", Callable(self, "_on_play_pressed"))
	$MarginContainer/VBoxContainer/Quit.connect("pressed", Callable(self, "_on_quit_pressed"))

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/playground.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
