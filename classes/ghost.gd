class_name ghost

extends CharacterBody2D

signal defeated

var timer : Timer

@export var x_speed : float

@export var y_speed : float

#generates "random" value between - threshold and threshold 
@export var x_threshold : float

@export var y_threshold : float

func _ready():
	timer = get_node("Timer")
	timer.set_paused(true);
	get_node("Sprite2D").texture = load("res://assets/GOSE/Ghost" + str(randi_range(1,4)) + ".png")

func _process(_delta):
	if !timer.is_stopped():
		modulate = Color(1,1,1,timer.time_left/timer.wait_time)
	
	x_speed += randf_range(-x_threshold,x_threshold)
	y_speed += randf_range(-y_threshold,y_threshold)
	
	var position_x = self.position.x + get_node("Sprite2D").texture.get_width()
	
	#TODO: fix odrazeni
	if((self.position.x + get_node("Sprite2D").texture.get_width()/2) > DisplayServer.window_get_size().x || (self.position.x - get_node("Sprite2D").texture.get_width()/2) < 0):
		x_speed *= -1
	
	if((self.position.y + get_node("Sprite2D").texture.get_height()/2) > DisplayServer.window_get_size().y || (self.position.y - get_node("Sprite2D").texture.get_height()/2) < 0):
		y_speed *= -1
	
	self.position += Vector2(x_speed,y_speed)


func _on_timer_timeout():
	defeated.emit(self)


func _on_mouse_entered():
	timer.set_paused(false)


func _on_mouse_exited():
	timer.set_paused(true)
