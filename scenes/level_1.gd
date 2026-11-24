extends Node2D

@onready var ui: CanvasLayer = $UI
@onready var player: CharacterBody2D = $Player
@onready var treasure_point: Marker2D = $TreasurePoint
@onready var treasure_sprite: Sprite2D = $TreasurePoint/Sprite2D

# Mantenha true para enxergar o tesouro nos testes; mude para false na entrega final
@export var debug_show_treasure: bool = true

func _ready() -> void:
	var ts: int = player.tile_size
	
	var player_grid := Vector2i(floor(player.position.x / ts), floor(player.position.y / ts))
	var treasure_grid := Vector2i(floor(treasure_point.position.x / ts), floor(treasure_point.position.y / ts))
	
	# Não alteramos mais treasure_point.position aqui; ele fica exatamente onde você colocou
	GameManager.treasure_grid_pos = treasure_grid
	GameManager.is_action_blocked = false
	
	# Calcula a diferença em passos para você conferir no Output
	var diff: Vector2i = treasure_grid - player_grid
	var dir_v := "%d Norte" % abs(diff.y) if diff.y < 0 else "%d Sul" % diff.y
	var dir_h := "%d Leste" % diff.x if diff.x > 0 else "%d Oeste" % abs(diff.x)
	print("Gabarito desta fase: ", dir_v, ", ", dir_h)
	
	treasure_sprite.visible = debug_show_treasure
	GameManager.level_completed.connect(_on_treasure_found)
	
	# Ajuste este texto conforme o gabarito impresso no Output
	ui.set_clue_text("3 passos para o Norte, 2 passos para o Leste.")

func _on_treasure_found() -> void:
	treasure_sprite.visible = true
