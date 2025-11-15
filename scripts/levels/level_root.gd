extends Node2D

@export var scroll_speed: float = 200.0  # pixels por segundo, ajuste depois

func _physics_process(delta: float) -> void:
	# anda tudo pra esquerda
	position.x -= scroll_speed * delta
