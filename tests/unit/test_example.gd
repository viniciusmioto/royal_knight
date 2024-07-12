extends GutTest

func test_play_button():
	# Create an instance of the Menu scene
	var menu_scene = load("res://scenes/menu.tscn").instantiate()
	add_child(menu_scene)
	
	# Create an instance of InputSender and add the Play button as a receiver
	var play_button = menu_scene.get_node("Play")
	var sender = InputSender.new(play_button)
	
	# Simulate the button press
	sender.action_press("ui_accept")
	sender.action_release("ui_accept")
	
	# Await to allow the signal to be processed
	await sender.idle
	
	# Verify that the scene changed to the playground
	assert_true(get_tree().current_scene.filename == "res://scenes/playground.tscn")
