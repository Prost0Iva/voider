extends Node2D


func _ready() -> void:
	Gui.init_buttons(self)

func _process(delta: float) -> void:
	if $CharacterChoose.visible == false:
		$MultiplayerTest.visible = 1
