extends CharacterBody2D

@export var tile_size: int = 64
@export var move_speed: float = 0.2

# Guarda a posição do jogador em coordenadas inteiras da grelha (ex: x=2, y=3)
var grid_position: Vector2i = Vector2i.ZERO
var is_moving: bool = false

func _ready() -> void:
	# Define a posição inicial na grelha com base na posição da cena
	grid_position = Vector2i(round(position.x / tile_size), round(position.y / tile_size))
	position = Vector2(grid_position * tile_size)

func _process(_delta: float) -> void:
	if is_moving or GameManager.is_action_blocked:
		return

	var direction: Vector2i = Vector2i.ZERO

	if Input.is_action_just_pressed("move_norte"):
		direction = Vector2i.UP
	elif Input.is_action_just_pressed("move_sul"):
		direction = Vector2i.DOWN
	elif Input.is_action_just_pressed("move_leste"):
		direction = Vector2i.RIGHT
	elif Input.is_action_just_pressed("move_oeste"):
		direction = Vector2i.LEFT
	elif Input.is_action_just_pressed("cavar"):
		execute_dig()
		return

	if direction != Vector2i.ZERO:
		move_grid(direction)

func move_grid(direction: Vector2i) -> void:
	grid_position += direction
	var target_position = Vector2(grid_position * tile_size)
	
	is_moving = true
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, move_speed)
	tween.finished.connect(func(): is_moving = false)

func execute_dig() -> void:
	GameManager.check_dig(grid_position);