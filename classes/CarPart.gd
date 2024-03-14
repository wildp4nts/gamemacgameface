class_name CarPart

extends Sprite2D

signal clicked_on

var mouse_in : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("mouse_click") and mouse_in:
		clicked_on.emit()


func _on_static_body_2d_mouse_entered():
	mouse_in = true


func _on_static_body_2d_mouse_exited():
	mouse_in = false
