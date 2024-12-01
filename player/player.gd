extends CharacterBody2D

# Constantes de velocidad y salto
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite = $AnimatedSprite2D

# Función _ready() para inicializar
func _ready() -> void:
	# Iniciar la animación "idle" cuando el NPC comienza
	animated_sprite.play("idle")

# Función _physics_process para manejar la física y el movimiento
func _physics_process(delta: float) -> void:
	# Obtener la dirección del movimiento (izquierda/derecha)
	var direction = Input.get_axis("ui_left", "ui_right")
	
	# Manejar el salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():  # Asegúrate de que esté en el suelo
		velocity.y = JUMP_VELOCITY  # Aplica la velocidad de salto
		#animated_sprite.play("jump")  # Cambia a la animación de salto
	
	# Movimiento horizontal (caminar)
	if direction != 0:
		velocity.x = direction * SPEED  # Movimiento horizontal
		if velocity.y == 0:  # Solo si no está en el aire
			animated_sprite.play("run")  # Reproduce la animación de caminar
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)  # Desaceleración al soltar la tecla
		if velocity.y == 0:  # Solo si no está en el aire
			animated_sprite.play("idle")  # Reproduce la animación de idle
	
	# Aplicar la física de movimiento (esto es importante para el salto)
	move_and_slide()
