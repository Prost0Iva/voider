extends Node2D

@onready var background_layers = [
	$Background/Layer,
	$Background/Layer2,
	$Background/Layer3,
	$Background/Layer4
]

func _ready() -> void:
	Gui.init_buttons(self)
	pass

func _process(_delta: float) -> void:
	parallax()

func parallax():
	var strengths = [5, 20, 15, 35]
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_size = get_viewport().get_visible_rect().size
	var offset = (mouse_pos - screen_size / 2) / (screen_size / 2)
	for i in background_layers.size():
		var layer = background_layers[i]
		layer.position = offset * strengths[i]
