class_name car

extends Node2D

var opened : bool = false

var mouse_in : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func open():
	get_node("CarBody").texture = load("res://assets/CAR_PLACEHOLDER_OPEN.png")
	var car_parts : Array = get_tree().get_nodes_in_group("visible_after_opening");
	for car_part in car_parts:
		car_part.visible = true
	opened = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("mouse_click") and mouse_in:
		if !opened:
			open()


func _on_static_body_2d_mouse_entered():
	mouse_in = true


func _on_static_body_2d_mouse_exited():
	mouse_in = false
