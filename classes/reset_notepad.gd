class_name ResetNotepad

extends Node2D

signal next_car

var show_note : bool
var move : bool = false
var timer : Timer
var notepad : Sprite2D
@export var speed : int

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_node("Timer")
	notepad = get_node("Sprite2D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ( ! move):
		return
	
	if (show_note):
		notepad.position.y -= speed * delta
	else:
		notepad.position.y += speed * delta

func show_notepad():
	show_note = true
	move = true
	timer.start()

func hide_notepad():
	show_note = false
	move = true
	timer.start()

func _on_timer_timeout():
	move = false
	if (show_note == false):
		next_car.emit()


func _on_texture_button_pressed():
	hide_notepad()
