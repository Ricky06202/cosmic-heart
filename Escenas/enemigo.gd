extends Area2D

var velocidadCaida = 200
@onready var vida: Vida = $Vida

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += velocidadCaida * delta
	
	if position.y > 2500:
		queue_free()

func _on_vida_morir() -> void:
	queue_free()

func _on_vida_daño_recibido(cantidad: Variant) -> void:
	var tween = create_tween()
	modulate = Color.RED
	tween.tween_property(self, "modulate", Color.WHITE, 0.1).set_trans(Tween.TRANS_CIRC)


func _on_body_entered(body: Node2D) -> void:
	(body.vida as Vida).recibir_daño(1)
	queue_free()
