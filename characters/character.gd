extends CharacterBody2D

@export var SPEED: float
@export var SPRINT: float
var is_moving: bool = false
var is_running: bool = false

@onready var _Texture = $Texture

var authority_id: int = 1

func _physics_process(_delta: float) -> void:
	z_index = position.y
	move()
	texture()

func move():
	var direction = Vector2(Input.get_axis("Left","Right"),Input.get_axis("Up","Down"))
	if direction:
		velocity = direction.normalized() * SPEED
		if Input.is_action_pressed("Sprint"):
			velocity *= SPRINT
			is_running = true
		else: is_running = false
		is_moving = true
	else:
		velocity = Vector2(move_toward(velocity.x, 0, 10), move_toward(velocity.y, 0, 10))
		is_moving = false
	move_and_slide()

func texture():
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_size = get_viewport().get_visible_rect().size
	var mouse_offset = (mouse_pos - screen_size / 2) / (screen_size / 2)
	if !is_moving:
		if mouse_offset.x >= 0:
			_Texture.animation = "default_right"
		else: _Texture.animation = "default_left"
	elif !is_running:
		if velocity.x >= 0:
			_Texture.animation = "walk_right"
		else: _Texture.animation = "walk_left"
	else:
		if velocity.x >= 0:
			_Texture.animation = "run_right"
		else: _Texture.animation = "run_left"
