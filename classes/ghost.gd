class_name ghost

extends CharacterBody2D

signal defeated

var timer : Timer

@export var x_speed : float

@export var y_speed : float

#generates "random" value between - threshold and threshold 
@export var x_threshold : float

@export var y_threshold : float

@export var max_speed : int

var window_id: int

func _ready():
	timer = get_node("Timer")
	timer.set_paused(true)
	get_node("Sprite2D").texture = load("res://assets/GOSE/Ghost" + str(randi_range(1,4)) + ".png")
	position = Vector2(randi_range(150,get_viewport().size.x-150), randi_range(150,get_viewport().size.y-150)) #150 je zde aby se nespawnovali v hranicích okna, neni to ideal, ale funguje +-

func _process(delta):
	if !timer.is_stopped():
		modulate = Color(1,1,1,timer.time_left/timer.wait_time)
	
	x_speed += randf_range(-x_threshold,x_threshold)*delta
	y_speed += randf_range(-y_threshold,y_threshold)*delta
	
	if (x_speed > max_speed):
		x_speed = max_speed
	if (y_speed > max_speed):
		y_speed = max_speed
	
	self.position += Vector2(x_speed,y_speed)


func _on_timer_timeout():
	defeated.emit(self)


func _on_mouse_entered():
	timer.set_paused(false)


func _on_mouse_exited():
	timer.set_paused(true)
