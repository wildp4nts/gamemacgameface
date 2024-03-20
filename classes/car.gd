class_name car

extends Node2D

@export var min_enemies_count : int

var opened : bool = false

var mouse_in : bool = false

var enemies_to_spawn : int

var enemies_to_defeat : int

var enemies : Array[Resource] = [preload("res://classes/ghost.tscn")]

# Called when the node enters the scene tree for the first time.
func _ready():
	var car_parts : Array[Node] = get_tree().get_nodes_in_group("car_part")
	enemies_to_spawn = randi_range(min_enemies_count, car_parts.size())
	enemies_to_defeat = enemies_to_spawn
	print(enemies_to_defeat)
	for car_part in car_parts:
		car_part.clicked_on.connect(_on_clicked_on_part)

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


func _on_clicked_on_part():
	if (enemies_to_spawn <= 0): 
		return
	
	var instance : Node = enemies[randi_range(0,enemies.size() - 1)].instantiate()
	add_child(instance)
	instance.defeated.connect(enemy_defeated)
	enemies_to_spawn -= 1


func enemy_defeated(instance):
	instance.queue_free()
	print("defeated")
	enemies_to_defeat -= 1
	if (enemies_to_defeat == 0):
		print("defeated all enemies")
	
