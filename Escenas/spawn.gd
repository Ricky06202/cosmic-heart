extends Node2D

@onready var enemy : PackedScene = load("res://Escenas/Enemigo.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var nuevoEnemigo = enemy.instantiate() as Area2D
	nuevoEnemigo.position.x = randf_range(100, get_viewport_rect().size.x - 100)
	add_child(nuevoEnemigo)
