extends Node2D

@export var min_enemies_count : int

var enemies_to_spawn : int

var enemies_to_defeat : int

var enemies_on_screen : int = 0

var enemies : Array[Resource] = [preload("res://classes/ghost.tscn")]

var hand : Resource = preload("res://assets/HAND.png")
var hand_cross : Resource = preload("res://assets/HAND_CROSS.png")

func _ready():
	Input.set_custom_mouse_cursor(hand)
	get_node("left").body_entered.connect(_on_x_body_entered)
	get_node("right").body_entered.connect(_on_x_body_entered)
	get_node("up").body_entered.connect(_on_y_body_entered)
	get_node("down").body_entered.connect(_on_y_body_entered)
	get_node("ResetNotepad").next_car.connect(_on_next_car)
	var engine = get_node("Car/Engine Bay")
	engine.clicked_on.connect(_on_clicked_on_engine)
	engine.fixed.connect(_on_fixed_engine)

	enemies_to_spawn = randi_range(min_enemies_count, engine.engine_parts_count)
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
	enemies_on_screen += 1
	Input.set_custom_mouse_cursor(hand_cross,Input.CURSOR_ARROW,Vector2(111,60))

func enemy_defeated(instance):
	instance.queue_free()
	enemies_to_defeat -= 1
	enemies_on_screen -= 1
	
	if (enemies_on_screen == 0):
		Input.set_custom_mouse_cursor(hand)
	
	get_node("AudioStreamDefeat").stream = load("res://assets/noises/ghost_end" + str(randi_range(1,3)) + ".mp3")
	get_node("AudioStreamDefeat").stream.loop = false
	get_node("AudioStreamDefeat").play()
	
	if (enemies_to_defeat == 0):
		$Notepad/LabelGhosts/StrikeThrough.visible = true
		$Notepad/LabelRemaing.text = "Remaining: 0"
		if ($Notepad/LabelCar/StrikeThrough.visible == true):
			get_node("ResetNotepad").show_notepad()

func _on_fixed_engine():
	$Notepad/LabelCar/StrikeThrough.visible = true
	if (enemies_to_defeat == 0):
		get_node("ResetNotepad").show_notepad()

func _on_next_car():
	get_tree().reload_current_scene()
