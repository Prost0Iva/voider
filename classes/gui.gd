class_name Gui

static func init_buttons(tree: Node):
	var buttons = tree.get_tree().get_nodes_in_group("Button")
	for button in buttons:
		button.mouse_entered.connect(_on_button_mouse_entered.bind(button))
		button.mouse_exited.connect(_on_button_mouse_exited.bind(button))
		button.input_event.connect(_on_button_input_event)

static func _on_button_mouse_entered(button: Node):
	var texture = button.get_child(0)
	texture.texture.region.position.x = 128
static func _on_button_mouse_exited(button: Node):
	var texture = button.get_child(0)
	texture.texture.region.position.x = 0
static func _on_button_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("LeftClick"):
		print("Watafa")
