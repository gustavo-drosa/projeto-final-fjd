extends Node2D

@onready var ui: CanvasLayer = $UI

# Posição fixa do tesouro no grid para a Fase 1
var level_treasure_pos: Vector2i = Vector2i(4, 2)

func _ready() -> void:
	GameManager.treasure_grid_pos = level_treasure_pos
	GameManager.is_action_blocked = false
	ui.set_clue_text("3 passos para o Norte, 2 passos para o Leste.")
