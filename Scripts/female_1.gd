class_name Teacher
extends Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_face("neutral", 2, 6, 5)
	add_face("happy", 0, 0, 0)
	add_face("excited", 4, 4, 3)
	add_face("serious", 1, 2, 1)
	add_face("concerned", 4, 8, 7)
	
	add_face("ERROR", 3, 0, 0)
	
	set_face("neutral")
