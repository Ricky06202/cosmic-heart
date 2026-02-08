extends Area2D

var velocidad := 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_level = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= velocidad * delta
	
	if position.y < -100:
		queue_free()
