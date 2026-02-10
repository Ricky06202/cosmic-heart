extends Area2D

var velocidad := 1500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_level = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= velocidad * delta
	
	if position.y < -100:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemigo"):
		var vida = area.get_node("Vida") as Vida
		vida.recibir_daño(1)
		queue_free()
