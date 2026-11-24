extends Control

@onready var score_label: Label = $VBoxContainer/ScoreLabel
@onready var restart_button: Button = $VBoxContainer/RestartButton

func _ready() -> void:
	score_label.text = "Tesouro encontrado!\nPontuação final: " + str(GameManager.current_score)
	restart_button.pressed.connect(_on_restart_pressed)

func _on_restart_pressed() -> void:
	GameManager.reset_stats()
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
