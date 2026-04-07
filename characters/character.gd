extends CharacterBody2D


var SPEED = 100.0
var is_moving: bool = false

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority():
		z_index = position.y
		move()
		texture()

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
