extends CanvasLayer

@onready var lives_label: Label = $MarginContainer/HBoxContainer/LivesLabel
@onready var score_label: Label = $MarginContainer/HBoxContainer/ScoreLabel
@onready var clue_label: Label = $MarginContainer/HBoxContainer/ClueLabel

func _ready() -> void:
	GameManager.lives_changed.connect(update_lives)
	GameManager.score_changed.connect(update_score)
	
	# Atualização inicial
	update_lives(GameManager.current_lives)
	update_score(GameManager.current_score)

func update_lives(new_lives: int) -> void:
	lives_label.text = "Vidas: " + str(new_lives)

func update_score(new_score: int) -> void:
	score_label.text = "Pontuação: " + str(new_score)

func set_clue_text(text: String) -> void:
	clue_label.text = "Dica: " + text