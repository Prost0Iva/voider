extends CharacterBody2D

var SPEED = 100.0
var is_moving: bool = false

var authority_id: int = 1

func _enter_tree():
	set_multiplayer_authority(authority_id)

func _ready() -> void:
	$Camera2D.enabled = is_multiplayer_authority()

func _physics_process(_delta: float) -> void:
	z_index = position.y
	if not is_multiplayer_authority(): return
	move()
	texture()
	
	sync_position.rpc(position, $Texture.animation)


func move():
	var direction := Vector2(Input.get_axis("Left","Right"),Input.get_axis("Up","Down"))
	if direction:
		velocity = direction.normalized() * SPEED
		is_moving = true
	else:
		velocity = Vector2(move_toward(velocity.x, 0, 10), move_toward(velocity.y, 0, 10))
		is_moving = false
	move_and_slide()

func texture():
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_size = get_viewport().get_visible_rect().size
	var mouse_offset = (mouse_pos - screen_size / 2) / (screen_size / 2)
	if is_moving == false:
		if mouse_offset.x >= 0:
			$Texture.animation = "default_right"
		else: $Texture.animation = "default_left"
	else:
		if velocity.x >= 0:
			$Texture.animation = "walk_right"
		else: $Texture.animation = "walk_left"

@rpc("any_peer", "unreliable")
func sync_position(new_pos: Vector2, new_anim):
	if not is_multiplayer_authority():
		position = new_pos
		$Texture.animation = new_anim
