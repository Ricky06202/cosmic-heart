extends CharacterBody2D

@onready var destello : PackedScene = load("res://Escenas/Destello.tscn")
@onready var marker_2d: Marker2D = $Marker2D

const SPEED = 700.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_timer_timeout() -> void:
	var nuevoDestello = destello.instantiate() as Node2D
	nuevoDestello.global_position = marker_2d.global_position
	marker_2d.add_child(nuevoDestello)
