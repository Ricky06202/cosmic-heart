extends Area2D

var velocidadCaida = 200
@onready var cristal : PackedScene = load("res://Escenas/Cristal.tscn")
@onready var sprite_2d: Sprite2D = $Sprite2D

var sprites = [
	preload("res://Assets/nube1.png"),
	preload("res://Assets/nube2.png"),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sprite = randi() % sprites.size()
	sprite_2d.texture = sprites.get(sprite)
	
	var voltear = randi() % 2
	sprite_2d.flip_h = voltear


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += velocidadCaida * delta
	
	if position.y > 2500:
		queue_free()

func _on_vida_morir() -> void:
	call_deferred("soltar_recompensa")
	Globals.enemigoDerrotado.emit()
	queue_free()

func soltar_recompensa():
	var soltarCristal = randf()
	if soltarCristal <= 0.30:
		var nuevoCristal : Area2D = cristal.instantiate()
		# Usamos get_parent() con cuidado o el nodo principal de la escena
		get_parent().add_child(nuevoCristal)
		nuevoCristal.global_position = global_position

func _on_vida_daño_recibido(cantidad: Variant) -> void:
	var tween = create_tween()
	modulate = Color.RED
	tween.tween_property(self, "modulate", Color.WHITE, 0.1).set_trans(Tween.TRANS_CIRC)


func _on_body_entered(body: Node2D) -> void:
	var vida = body.get_node("Vida") as Vida
	vida.recibir_daño(1)
	queue_free()
