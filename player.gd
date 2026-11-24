extends CharacterBody2D

@export var tile_size: int = 16
@export var move_speed: float = 0.2

var initial_grid_position: Vector2i = Vector2i.ZERO
var grid_position: Vector2i = Vector2i.ZERO
var is_moving: bool = false
var move_tween: Tween

func _ready() -> void:
	grid_position = Vector2i(floor(position.x / tile_size), floor(position.y / tile_size))
	initial_grid_position = grid_position
	position = Vector2(grid_position * tile_size) + Vector2(tile_size, tile_size) * 0.5




func _process(_delta: float) -> void:
	if GameManager.is_action_blocked:
		return

	# Permite resetar a qualquer momento (mesmo durante o deslocamento)
	if Input.is_action_just_pressed("resetar"):
		reset_position()
		return

	if is_moving:
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
	var target_position = Vector2(grid_position * tile_size) + Vector2(tile_size, tile_size) * 0.5
	
	is_moving = true
	move_tween = create_tween()
	move_tween.tween_property(self, "position", target_position, move_speed)
	move_tween.finished.connect(func(): is_moving = false)

func reset_position() -> void:
	if move_tween and move_tween.is_valid():
		move_tween.kill()
	
	is_moving = false
	grid_position = initial_grid_position
	position = Vector2(initial_grid_position * tile_size) + Vector2(tile_size, tile_size) * 0.5

func execute_dig() -> void:
	print("Cavando em: ", grid_position, " | Tesouro está em: ", GameManager.treasure_grid_pos)
	GameManager.check_dig(grid_position)