extends CanvasLayer

@onready var cristales: Label = $Contadores/Cristales/MarginContainer/Cristales/VBoxContainer/Contador
@onready var cristalesBar: ProgressBar = $Contadores/Cristales/MarginContainer/Cristales/VBoxContainer/ProgressBar

@onready var enemigos: Label = $Contadores/Enemigos/MarginContainer/Enemigos/Contador

signal memoriaRecuperada

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.cristalAtrapado.connect(aumentarCristales)
	Globals.enemigoDerrotado.connect(aumentarEnemigos)
	cristalesBar.max_value = 10
	cristalesBar.value = 0

func aumentarCristales():
	cristales.text = str(int(cristales.text) + 1)
	cristalesBar.value += 1
	if cristalesBar.value >= 10:
		memoriaRecuperada.emit()
	
func aumentarEnemigos():
	enemigos.text = str(int(enemigos.text) + 1)


func _on_memoria_recuperada() -> void:
	get_tree().paused = true
	
	cristales.text = "0"
	cristalesBar.value = 0
