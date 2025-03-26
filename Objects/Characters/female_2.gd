class_name Friend2
extends Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_face("neutral", 3, 4, 3)
	add_face("happy", 1, 4, 3)
	add_face("excited", 5, 4, 3)
	add_face("concerned", 2, 6, 5)
	add_face("serious", 4, 2, 1)
	add_face("upset", 4, 6, 5)
	add_face("shocked", 5, 7, 1)
	add_face("complaining", 4, 7, 1)
	
	add_face("ERROR", 0, 0, 0)
	
	set_face("neutral")
