extends Area2D

var velocidad := 300

var sprites = [
	preload("res://Assets/Cristal amarillo.png"),
	preload("res://Assets/Cristal azul.png"),
	preload("res://Assets/Cristal morado.png"),
	preload("res://Assets/Cristal naranja.png"),
	preload("res://Assets/Cristal rosa.png"),
	preload("res://Assets/Cristal verde.png"),
]

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	var sprite = randi() % sprites.size()
	sprite_2d.texture = sprites.get(sprite)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += velocidad * delta
	
	if position.y < -100:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	Globals.cristalAtrapado.emit()
	queue_free()
