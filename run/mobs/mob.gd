extends CharacterBody2D

@export var SPEED: float
@export var HEALTH: float

@onready var _Texture = $Texture
@onready var _Path = $Path


func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:
	z_index = position.y
	if !_Path.is_navigation_finished():
		var direction = _Path.get_next_path_position() - position
		move(direction)
	texture()
	
	if Input.is_action_just_pressed("LeftClick"):
		var mouse_position = get_global_mouse_position()
		_Path.target_position = mouse_position

func move(direction: Vector2):
	if direction:
		velocity = direction.normalized() * SPEED
	else:
		velocity = Vector2(move_toward(velocity.x, 0, 10), move_toward(velocity.y, 0, 10))
	move_and_slide()

func texture():
	if velocity.x >= 0:
		_Texture.flip_h = true
	else: _Texture.flip_h = false
