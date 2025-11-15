extends CharacterBody2D

@export_category("Movement")
@export var speed: float = 200.0

@export_category("Jump Physics")
@export var gravity: float = 2600.0
@export var jump_force: float = -900.0
@export var max_fall_speed: float = 1600.0

@export_category("Jump Assist")
@export var coyote_time: float = 0.08        # 80 ms
@export var jump_buffer_time: float = 0.12   # 120 ms
@export var jump_cut_factor: float = 0.5     # 0.0–1.0

var _coyote_timer := 0.0
var _jump_buffer_timer := 0.0

func _physics_process(delta: float) -> void:
	# Atualiza timers de coyote/jump buffer
	if is_on_floor():
		_coyote_timer = coyote_time
	else:
		_coyote_timer -= delta

	if Input.is_action_just_pressed("ui_accept"):
		_jump_buffer_timer = jump_buffer_time
	else:
		_jump_buffer_timer -= delta

	# Gravidade
	if velocity.y < max_fall_speed:
		velocity.y += gravity * delta

	# Pulo: só se estiver dentro das janelas de coyote + buffer
	if _jump_buffer_timer > 0.0 and _coyote_timer > 0.0:
		velocity.y = jump_force
		_jump_buffer_timer = 0.0
		_coyote_timer = 0.0

	# Cortar pulo ao soltar botão (pra pulo curto)
	if Input.is_action_just_released("ui_accept") and velocity.y < 0.0:
		velocity.y *= jump_cut_factor

	# Runner: player não anda por input (fase se move)
	velocity.x = 0.0

	move_and_slide()
