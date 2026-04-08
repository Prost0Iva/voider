extends CanvasLayer

var character = preload("res://characters/character.tscn")

func _ready() -> void:
	init_buttons()

func _process(delta: float) -> void:
	pass

func init_buttons():
	var buttons = get_tree().get_nodes_in_group("CharacterButton")
	for button in buttons:
		button.mouse_entered.connect(_on_button_mouse_entered.bind(button))
		button.mouse_exited.connect(_on_button_mouse_exited.bind(button))
		button.input_event.connect(_on_button_input_event.bind(button))

func _on_button_mouse_entered(button: Node):
	var texture = button.get_child(0)
	var label = button.get_child(1)
	texture.scale = Vector2(4,4)
	label.visible = 1
	var preview_anim = create_tween()
	var info_anim = create_tween()
	preview_anim.tween_property($CharacterPreview, "position:x", 1511, .4)
	info_anim.tween_property($InfoPreview, "position:x", 34, .4)
	init_info(button.name)
func _on_button_mouse_exited(button: Node):
	var texture = button.get_child(0)
	var label = button.get_child(1)
	texture.scale = Vector2(3,3)
	label.visible = 0
	var preview_anim = create_tween()
	var info_anim = create_tween()
	preview_anim.tween_property($CharacterPreview, "position:x", 2511, .4)
	info_anim.tween_property($InfoPreview, "position:x", -1216, .4)

func _on_button_input_event(viewport: Viewport, event: InputEvent, shape_idx: int, button: Node) -> void:
	if event is InputEventMouseButton and event.pressed:
		init_character(button.name)
		$".".visible = 0

func init_info(character_name: String):
	$CharacterPreview.texture.atlas = load("res://assets/textures/characters/" + CharactersInfo.character_choose[character_name].texture)
	$InfoPreview/CharacterName.text = CharactersInfo.character_choose[character_name].name
	$InfoPreview/CharacterDescription.text = CharactersInfo.character_choose[character_name].description

func init_character(character_name: String):
	var init_character = character.instantiate()
	init_character.get_child(1).sprite_frames = load("res://assets/tres/characters_anim/" + CharactersInfo.character_choose[character_name].anim)
	init_character.position = Vector2(CharactersInfo.character_choose[character_name].pos[0], CharactersInfo.character_choose[character_name].pos[1])
	init_character.name = character_name
	$"..".add_child(init_character)
