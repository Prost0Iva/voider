extends Node2D


func _ready() -> void:
	Gui.init_buttons(self)

func _process(delta: float) -> void:
	if !$CharacterChoose.visible and !$MultiplayerTest.STATUS:
		$MultiplayerTest.visible = 1
	else: $MultiplayerTest.visible = 0
