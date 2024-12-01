extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
@onready var anim = get_node("AnimatedSprite2D")
#var enemie: CharacterBody2D  # Declarar la variable enemie

var is_attacking = false  # Control para saber si está atacando

func _ready():
	anim.play("idle")
	
func _ready_tas():
	if not is_in_group("emperator"):
		add_to_group("emperator")

func _physics_process(delta: float) -> void:
	# Añade gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Reproduce la animación "attack" al presionar la Flecha Arriba
	if Input.is_action_just_pressed("ui_up") and not is_attacking:  # Solo atacar si no está atacando
		#print("Tecla Flecha Arriba presionada")
		anim.play("attack")
		is_attacking = true  # Marca que está atacando
	
	# Después de la animación de ataque, volver a "idle" o "walk"
	if anim.animation == "attack" and not anim.is_playing():
		is_attacking = false
		anim.play("idle")  # O "walk", dependiendo del estado del personaje

	# Maneja el salto
	elif Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		#anim.play("jump")  # Opcional: Si tienes una animación de salto

	# Obtén la dirección y maneja el movimiento
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		move_and_slide()
		for index in get_slide_collision_count(): 
			var collision: = get_slide_collision(index)
			if(collision.get_collider()):
				var otherCollider = collision.get_collider().name
				if(otherCollider == "enemie"):
					print("this is coollited with ", otherCollider.name)
			
			#var body := collision.collider
		if not is_attacking:
			anim.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not is_attacking:
			anim.play("idle")

	# Mueve al personaje
	move_and_slide()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
