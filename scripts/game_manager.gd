extends Node

signal lives_changed(new_lives: int)
signal score_changed(new_score: int)
signal game_over
signal level_completed

@export var max_lives: int = 3

var current_lives: int = 3
var current_score: int = 0

# Armazena a posição da célula (em coordenadas de grid) onde o tesouro está na fase atual
var treasure_grid_pos: Vector2i = Vector2i.ZERO
var is_action_blocked: bool = false

func _ready() -> void:
	reset_stats()

func reset_stats() -> void:
	current_lives = max_lives
	current_score = 0
	is_action_blocked = false
	lives_changed.emit(current_lives)
	score_changed.emit(current_score)

func check_dig(player_grid_pos: Vector2i) -> void:
	if is_action_blocked:
		return

	if player_grid_pos == treasure_grid_pos:
		# Acertou o tesouro
		current_score += 1
		score_changed.emit(current_score)
		is_action_blocked = true
		level_completed.emit()
	else:
		# Errou o local do tesouro
		current_lives -= 1
		lives_changed.emit(current_lives)
		
		if current_lives <= 0:
			is_action_blocked = true
			game_over.emit()