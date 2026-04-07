extends CanvasLayer

var peer = ENetMultiplayerPeer.new()
var last_character_anim
var last_character_pos

func _on_button_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("LeftClick"):
		peer.create_server(135)
		multiplayer.multiplayer_peer = peer


func _on_join_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("LeftClick"):
		last_character_anim = get_tree().get_nodes_in_group("Character")[0].get_child(1).sprite_frames
		last_character_pos = get_tree().get_nodes_in_group("Character")[0].position
		get_tree().get_nodes_in_group("Character")[0].queue_free()
		peer.create_client("localhost", 135)
		multiplayer.multiplayer_peer = peer


func _on_multiplayer_spawner_spawned(node: Node) -> void:
	node.get_child(1).sprite_frames = last_character_anim
	node.position = last_character_pos
