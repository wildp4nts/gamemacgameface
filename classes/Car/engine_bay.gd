extends Node2D

var engine_parts_count : int

signal clicked_on

# Called when the node enters the scene tree for the first time.
func _ready():
	var engine_parts : Array[Node] = get_tree().get_nodes_in_group("engine_part")
	for engine_part in engine_parts:
		engine_part.pressed.connect(_on_pressed)
	engine_parts_count = engine_parts.size()

func _on_pressed():
	clicked_on.emit()
