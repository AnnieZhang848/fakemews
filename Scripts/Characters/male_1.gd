class_name Friend1
extends Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_face("neutral", 4, 6, 9)
	add_face("happy", 3, 6, 9)
	add_face("excited", 5, 10, 9)
	add_face("concerned", 1, 3, 0)
	add_face("serious", 0, 3, 2)
	add_face("upset", 1, 1, 4)
	add_face("shocked", 5, 8, 7)
	add_face("complaining", 3, 1, 4)
	add_face("sheepish", 1, 5, 9)
	
	add_face("ERROR", 2, 4, 4)
	
	set_face("neutral")
