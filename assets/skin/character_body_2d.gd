extends CharacterBody2D

const SPEED = 200.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:

	var direction = Input.get_vector(
		"move_oeste",
		"move_leste",
		"move_norte",
        "move_sul"
	)

	velocity = direction * SPEED

	# Animações
	if direction != Vector2.ZERO:

		var anim_name = ""

		if abs(direction.x) > abs(direction.y):
			anim_name = "direita" if direction.x > 0 else "esquerda"
		else:
			anim_name = "baixo" if direction.y > 0 else "cima"

		if anim.animation != anim_name:
			anim.play(anim_name)

	move_and_slide()
