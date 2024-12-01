extends CharacterBody2D

# Nodo del sprite animado del NPC
@onready var animated_sprite = $AnimatedSprite2D
@onready var area = $Area2D  # Asegúrate de tener un nodo Area2D para detectar colisiones

func _ready() -> void:
	# Asegúrate de que la animación "idle" se inicie al comienzo
	animated_sprite.play("idle")

	# Conectamos la señal de colisión de Area2D
	area.body_entered.connect(_on_body_entered)

# Método que se llama cuando el área del NPC entra en contacto con otro cuerpo
func _on_body_entered(body):
	# Verifica si el cuerpo que entra es el jugador
	if body.is_in_group("emperator"):  # Asegúrate de que el jugador esté en el grupo "emperator_player"
		print("El jugador tocó al NPC")
		animated_sprite.play("die")  # Cambia la animación a "die"
