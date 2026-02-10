extends Area2D

var velocidadCaida = 200
@onready var cristal : PackedScene = load("res://Escenas/Cristal.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += velocidadCaida * delta
	
	if position.y > 2500:
		queue_free()

func _on_vida_morir() -> void:
	var soltarCristal = randf()
	if soltarCristal <= .30:
		var nuevoCristal : Area2D = cristal.instantiate()
		nuevoCristal.global_position = global_position
		get_parent().add_child(nuevoCristal)
		
	queue_free()

func _on_vida_daño_recibido(cantidad: Variant) -> void:
	var tween = create_tween()
	modulate = Color.RED
	tween.tween_property(self, "modulate", Color.WHITE, 0.1).set_trans(Tween.TRANS_CIRC)


func _on_body_entered(body: Node2D) -> void:
	var vida = body.get_node("Vida") as Vida
	vida.recibir_daño(1)
	queue_free()
