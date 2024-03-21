extends Node2D

func _ready():
	get_node("left").body_entered.connect(_on_x_body_entered)
	get_node("right").body_entered.connect(_on_x_body_entered)
	get_node("up").body_entered.connect(_on_y_body_entered)
	get_node("down").body_entered.connect(_on_y_body_entered)



func _on_x_body_entered(body):
	if (body is ghost):
		body.x_speed *= -1

func _on_y_body_entered(body):
	if (body is ghost):
		body.y_speed *= -1
