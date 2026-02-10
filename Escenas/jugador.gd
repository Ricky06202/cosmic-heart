extends CharacterBody2D

@onready var destello : PackedScene = load("res://Escenas/Destello.tscn")
@onready var marker_2d: Marker2D = $Marker2D

const velocidad = 10.0

var arrastrando = false
var offset_x = 0.0
var tween : Tween

@export var fuerza_atraccion := 10.0 # Qué tan rápido intenta alcanzar el dedo
@export var friccion := 0.15 # Cuánto le cuesta frenar (suavidad)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			arrastrando = true
			offset_x = global_position.x - get_global_mouse_position().x
		else:
			arrastrando = false

func _physics_process(delta):
	if arrastrando:
		var objetivo_x = get_global_mouse_position().x + offset_x
		# Calculamos la distancia que falta para llegar al mouse
		var distancia_x = objetivo_x - global_position.x
		
		# Aplicamos una velocidad proporcional a la distancia (Efecto resorte/tween)
		velocity.x = distancia_x * fuerza_atraccion
	else:
		# Si soltamos, frenamos suavemente
		velocity.x = lerp(velocity.x, 0.0, friccion)
	
	# IMPORTANTE: move_and_slide es lo que detecta las paredes
	move_and_slide()

func _on_timer_timeout() -> void:
	var nuevoDestello = destello.instantiate() as Node2D
	nuevoDestello.global_position = marker_2d.global_position
	marker_2d.add_child(nuevoDestello)


func _on_vida_morir() -> void:
	queue_free()


func _on_vida_daño_recibido(cantidad: Variant) -> void:
	var tween = create_tween()
	modulate = Color.RED
	tween.tween_property(self, "modulate", Color.WHITE, 0.1) 
