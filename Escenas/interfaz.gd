extends CanvasLayer

@onready var cristales: Label = $Contadores/Cristales/MarginContainer/Cristales/VBoxContainer/Contador
@onready var cristalesBar: ProgressBar = $Contadores/Cristales/MarginContainer/Cristales/VBoxContainer/ProgressBar

@onready var enemigos: Label = $Contadores/Enemigos/MarginContainer/Enemigos/Contador

@onready var memoria: Control = $Memoria
@onready var ganaste: Control = $Ganaste
@onready var perdiste: Control = $Perdiste

signal memoriaRecuperada
signal juegoCompletado

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.cristalAtrapado.connect(aumentarCristales)
	Globals.enemigoDerrotado.connect(aumentarEnemigos)
	cristalesBar.max_value = 10
	cristalesBar.value = 0
	Globals.perdiste.connect(_on_perdiste)
	#memoriaAleatoria()

func aumentarCristales():
	cristales.text = str(int(cristales.text) + 1)
	cristalesBar.value += 1
	if cristalesBar.value >= 10:
		memoriaRecuperada.emit()
	
func aumentarEnemigos():
	enemigos.text = str(int(enemigos.text) + 1)

var fotosMemorias = [
	preload("res://Assets/Memorias/Amigos2.png"),
	preload("res://Assets/Memorias/Amigos.png"),
	preload("res://Assets/Memorias/Boquete.png"),
	preload("res://Assets/Memorias/CarreraUTP.png"),
	preload("res://Assets/Memorias/FincaBoquete.png"),
	preload("res://Assets/Memorias/Mcdonals.png"),
	preload("res://Assets/Memorias/Parrillada.png"),
	preload("res://Assets/Memorias/PatosBoquete.png"),
	preload("res://Assets/Memorias/Unas.png"),
	preload("res://Assets/Memorias/ViajePanama.png")
]

var titulosMemorias = [
	"Coleccionistas de Risas",
	"El Corazón de nuestra Tribu",
	"Suspiros en la Montaña",
	"El Kilómetro Cero de Nosotros",
	"Nuestro Refugio de Paz",
	"La Felicidad en lo Simple",
	"Sabores que Unen",
	"Magia en lo Inesperado",
	"La Belleza en tus Detalles",
	"Horizontes Compartidos",
]

var descripcionMemorias = [
	"No son solo fotos, son pruebas de que estamos rodeados de luz. Adoro ver cómo nuestra gente nos quiere y cómo tú brillas en medio de todos. Cada persona en esta imagen es parte de nuestra historia, pero tú eres, sin duda, mi capítulo favorito.",
	"'Ohana significa familia, y tu familia nunca te abandona'. Ver cómo construimos este círculo de amigos me llena de orgullo. Eres el alma de este grupo, el pegamento que nos une y la razón por la que cada reunión es una fiesta para el corazón.",
	"El aire frío de Boquete y el calor de tu sonrisa. Perdernos en la naturaleza contigo es mi forma favorita de encontrar la paz. En este viaje entendí que, sin importar el paisaje, mi vista favorita siempre será la forma en que tus ojos brillan cuando eres feliz.",
	"¿Quién diría que una carrera sería el punto de partida para todo lo que somos hoy? Recuerdo los nervios, las risas entrecortadas por el esfuerzo y esa sensación mágica de que, aunque estábamos corriendo, el tiempo se detuvo cuando te vi. Fue el primer paso de un camino que espero no termine nunca.",
	"Hay lugares que se quedan grabados no por lo que ves, sino por lo que sientes. En la finca, entre el verde y el silencio, sentí que nuestra amistad es ese refugio donde siempre puedo ser yo mismo. Gracias por ser mi calma en medio de cualquier tormenta.",
	"A veces no necesitamos cenas de gala ni lujos para ser felices. Una hamburguesa, unas papas y tu compañía son suficientes para que cualquier momento ordinario se vuelva extraordinario. Adoro cómo transformas lo cotidiano en algo que guardo como un tesoro.",
	"Entre el humo de la parrilla y las bromas de siempre, se cocina algo mucho más importante: nuestra historia. Estos momentos de compartir la comida y la vida son los que alimentan mi alma. Espero que vengan mil parrilladas más, siempre contigo al mando de las risas.",
	"Ver los patos y reírnos por cosas tan simples... esos son los momentos que más extraño cuando no estamos cerca. Tienes ese don especial de encontrar magia en los animales, en la naturaleza y en la vida misma, y me siento el más afortunado por poder presenciarlo.",
	"Me encanta fijarme en esas pequeñas cosas que te hacen ser tú. Como cuando eliges con cuidado el color de tus uñas; es un reflejo de tu delicadeza y de cómo iluminas todo lo que tocas. Son esos detalles mínimos los que me recuerdan constantemente por qué te adoro tanto.",
	"Nuestro primer viaje fuera de la rutina, donde descubrí que viajar contigo no es solo ir a un lugar nuevo, sino encontrar un hogar en cualquier parte mientras estés a mi lado. Atravesar fronteras contigo me enseñó que no hay destino demasiado lejos si vamos de la mano.",
]

@onready var texture_rect: TextureRect = $Memoria/Panel/MarginContainer/VBoxContainer/TextureRect
@onready var titulo: Label = $Memoria/Panel/MarginContainer/VBoxContainer/Titulo
@onready var descripcion: Label = $Memoria/Panel/MarginContainer/VBoxContainer/Descripcion

func memoriaAleatoria():
	if fotosMemorias.size() == 0:
		juegoCompletado.emit()
		return false
		
	var memoria = randi_range(0, fotosMemorias.size()-1)
	texture_rect.texture = fotosMemorias.get(memoria)
	titulo.text = titulosMemorias.get(memoria)
	descripcion.text = descripcionMemorias.get(memoria)
	borrarMemoria(memoria)
	return true

func borrarMemoria(indice):
	fotosMemorias.remove_at(indice)
	titulosMemorias.remove_at(indice)
	descripcionMemorias.remove_at(indice)

func _on_memoria_recuperada() -> void:
	var hayMemorias = memoriaAleatoria()
	if not hayMemorias:
		return
		
	get_tree().paused = true
	memoria.visible = true

func _on_button_pressed() -> void:
	cristales.text = "0"
	cristalesBar.value = 0
	memoria.visible = false
	get_tree().paused = false


func _on_juego_completado() -> void:
	get_tree().paused = true
	ganaste.visible = true
	
func _on_perdiste():
	get_tree().paused = true
	perdiste.visible = true


func _on_reintentar_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

@onready var menu = load("res://Escenas/menu_principal.tscn")

func _on_volver_al_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(menu)
