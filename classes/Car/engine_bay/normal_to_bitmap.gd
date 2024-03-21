extends TextureButton

@export var node_name : String

func _ready():
	texture_click_mask.create_from_image_alpha(texture_normal.get_image())



func _on_pressed():
	get_node(node_name).visible = true
	disabled = true
