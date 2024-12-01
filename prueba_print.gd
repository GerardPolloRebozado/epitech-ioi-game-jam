extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func add_obs(obs, x, y):
	obs.position = Vector2i(x, y - 55)
	obs.body_entered.connect(hit_obs)
	add_child(obs)
	#obstacles.append(obs)

func hit_obs(body):
	if body.name == "emperator_player":
		print("somethign")
 
