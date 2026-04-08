extends CanvasLayer

var peer: ENetMultiplayerPeer
var PORT = 23
#var IP_ADRESS = "localhost"
var STATUS = false
@onready var spawner = $"../MultiplayerSpawner"

func _ready():
	spawner.spawn_function = spawn_player

func _on_host_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("LeftClick"):
		start_server()
		STATUS = true
func _on_join_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("LeftClick"):
		start_client()

func start_server():
	var host_char = get_tree().get_nodes_in_group("Character")[0]
	# Запоминаем данные хоста
	var host_data = {
		"character_name": host_char.name,
		"player_id": 1
	}
	# Удаляем старого персонажа
	host_char.queue_free()
	
	peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	
	spawner.spawn(host_data)

func start_client():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_client($Join/Adress.text, PORT)
	
	if error != OK:
		$Join/Adress.text = "Invalid address"
		return
	
	multiplayer.multiplayer_peer = peer
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	# Если не подключился за отведённое время
	multiplayer.connection_failed.connect(_on_connection_failed)

func _on_connection_failed():
	$Join/Adress.text = "Failed connection"
	multiplayer.multiplayer_peer = null  # сбрасываем peer

func _on_connected_to_server():
	STATUS = true
	var char = get_tree().get_nodes_in_group("Character")[0]
	var my_data = {
	"character_name": char.name,
	}
	char.queue_free()
	send_player_data.rpc_id(1, my_data)  # 1 = всегда ID хоста

@rpc("any_peer", "reliable")
func send_player_data(data: Dictionary):
	var sender_id = multiplayer.get_remote_sender_id()
	data["player_id"] = sender_id
	spawner.spawn(data)

func spawn_player(data: Dictionary) -> Node:
	var player_scene = preload("res://characters/character.tscn").instantiate()
	player_scene.name = str(data.player_id)
	player_scene.authority_id = data.player_id
	player_scene.get_child(1).sprite_frames = load("res://assets/tres/characters_anim/" + CharactersInfo.character_choose[data.character_name].anim)
	player_scene.position = Vector2(CharactersInfo.character_choose[data.character_name].pos[0], CharactersInfo.character_choose[data.character_name].pos[1])
	return player_scene
