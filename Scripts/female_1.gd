class_name Teacher
extends Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_face("neutral", 2, 6)
	add_face("serious", 1, 1)
	add_face("happy", 4, 4)
	add_face("concerned", 1, 2)
	
	set_face("neutral")
