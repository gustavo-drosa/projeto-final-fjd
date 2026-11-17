extends Node

signal lives_changed(new_lives: int)
signal score_changed(new_score: int)
signal game_over
signal level_completed

@export var max_lives: int = 3

var current_lives: int = 3
var current_score: int = 0
var current_level: int = 1

var treasure_grid_pos: Vector2i = Vector2i.ZERO
var is_action_blocked: bool = false

func _ready() -> void:
	reset_stats()
	level_completed.connect(_on_level_completed)
	game_over.connect(_on_game_over)

func reset_stats() -> void:
	current_lives = max_lives
	current_score = 0
	current_level = 1
	is_action_blocked = false
	lives_changed.emit(current_lives)
	score_changed.emit(current_score)

func check_dig(player_grid_pos: Vector2i) -> void:
	if is_action_blocked:
		return

	if player_grid_pos == treasure_grid_pos:
		current_score += 10
		score_changed.emit(current_score)
		is_action_blocked = true
		level_completed.emit()
	else:
		current_lives -= 1
		lives_changed.emit(current_lives)
		
		if current_lives <= 0:
			is_action_blocked = true
			game_over.emit()

func _on_level_completed() -> void:
	if current_level == 1:
		current_level = 2
		# Aguarda 1 segundo antes de mudar de cena para o jogador notar o acerto
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")
	else:
		# Conclusão das duas fases obrigatorias
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://scenes/victory.tscn")

func _on_game_over() -> void:
	await get_tree().create_timer(1.0).timeout
	reset_stats()
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")