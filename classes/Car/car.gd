extends Node2D

var cars : Array[String] = ["A", "B", "C"]

var is_open : bool = false

var hoodOpened
var hoodClosed

@onready var hood : TextureButton = get_node("hood")

# Called when the node enters the scene tree for the first time.
func _ready():
	var car : int = randi_range(0, cars.size() - 1)
	hoodOpened = load("res://assets/CAR/CAR_" + cars[car] + "/HOODO.png")
	hoodClosed = load("res://assets/CAR/CAR_" + cars[car] + "/HOODC.png")
	get_node("base").texture = load("res://assets/CAR/CAR_" + cars[car] + "/BASE.png")
	get_node("grill").texture = load("res://assets/CAR/CAR_" + cars[car] + "/GRILL" + str(randi_range(1, 2)) + ".png")
	get_node("headlights").texture = load("res://assets/CAR/CAR_" + cars[car] + "/HEADLIGHTS" + str(randi_range(1, 2)) + ".png")
	hood.texture_normal = hoodClosed
	hood.texture_click_mask.create_from_image_alpha(hoodClosed.get_image())
	get_node("regplt").texture = load("res://assets/CAR/CAR_" + cars[car] + "/REGPLT.png")
	if car != 1: #cars[1] = 'B'
		get_node("blinkers").texture = load("res://assets/CAR/CAR_" + cars[car] + "/BLINKERS.png")


func _on_hood_pressed():
	if ! is_open:
		hood.texture_normal = hoodOpened
		hood.texture_click_mask.create_from_image_alpha(hoodOpened.get_image())
	else:
		hood.texture_normal = hoodClosed
		hood.texture_click_mask.create_from_image_alpha(hoodClosed.get_image())
	is_open = !is_open
