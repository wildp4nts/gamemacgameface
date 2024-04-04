extends Node2D

@export var min_enemies_count : int

var enemies_to_spawn : int

var enemies_to_defeat : int

var enemies : Array[Resource] = [preload("res://classes/ghost.tscn")]

func _ready():
	get_node("left").body_entered.connect(_on_x_body_entered)
	get_node("right").body_entered.connect(_on_x_body_entered)
	get_node("up").body_entered.connect(_on_y_body_entered)
	get_node("down").body_entered.connect(_on_y_body_entered)
	var engine = get_node("Car/Engine Bay")
	engine.clicked_on.connect(_on_clicked_on_engine)

	enemies_to_spawn = randi_range(min_enemies_count, engine.engine_parts_count)
	print(enemies_to_spawn)
	enemies_to_defeat = enemies_to_spawn


func _on_x_body_entered(body):
	if (body is ghost):
		body.x_speed *= -1

func _on_y_body_entered(body):
	if (body is ghost):
		body.y_speed *= -1

func _on_clicked_on_engine():
	if (enemies_to_spawn == 0):
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
