extends Area2D

var velocidad := 300

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += velocidad * delta
	
	if position.y < -100:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	Globals.cristalAtrapado.emit()
	queue_free()
