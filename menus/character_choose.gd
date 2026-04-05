extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_buttons()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func init_buttons():
	var buttons = get_tree().get_nodes_in_group("CharacterButton")
	for button in buttons:
		button.mouse_entered.connect(_on_button_mouse_entered.bind(button))
		button.mouse_exited.connect(_on_button_mouse_exited.bind(button))
		button.input_event.connect(_on_button_input_event)

func _on_button_mouse_entered(button: Node):
	var texture = button.get_child(0)
	var label = button.get_child(1)
	texture.scale = Vector2(4,4)
	label.visible = 1
	var preview_anim = create_tween()
	var info_anim = create_tween()
	preview_anim.tween_property($CharacterPreview, "position:x", 1511, .4)
	info_anim.tween_property($InfoPreview, "position:x", 34, .4)
func _on_button_mouse_exited(button: Node):
	var texture = button.get_child(0)
	var label = button.get_child(1)
	texture.scale = Vector2(3,3)
	label.visible = 0
	var preview_anim = create_tween()
	var info_anim = create_tween()
	preview_anim.tween_property($CharacterPreview, "position:x", 2511, .4)
	info_anim.tween_property($InfoPreview, "position:x", -966, .4)
func _on_button_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("LeftClick"):
		print("Watafa")
