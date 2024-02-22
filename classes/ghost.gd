class_name ghost

extends CharacterBody2D

signal defeated

var timer : Timer

func _ready():
	timer = get_node("Timer")
	timer.set_paused(true);

func _process(_delta):
	if !timer.is_stopped():
		modulate = Color(1,1,1,timer.time_left/timer.wait_time)


func _on_timer_timeout():
	defeated.emit()
	print("despawn")


func _on_mouse_entered():
	timer.set_paused(false)


func _on_mouse_exited():
	timer.set_paused(true)
