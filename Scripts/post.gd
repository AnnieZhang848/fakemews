extends Control

@onready var title = $ColorRect/Title
@onready var body = $ColorRect/Body



func setup_post(Title : String, Body : String):
	title.text = Title
	body.text = Body	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
