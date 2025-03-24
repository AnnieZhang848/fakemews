extends Control

@onready var Post = preload("res://Objects/Post.tscn")

var Options = ["res://FallacyOptions/Example1.txt"]

func load_from_file(index : int = 0):
	if index < 0 or FileAccess.file_exists(Options[index]) == false:
		print("Error loading from index: %s" % index)
		return
	var file = FileAccess.open(Options[0],FileAccess.READ)
	var content = file.get_as_text()
	clean_text(content)

func clean_text(content : String):
	var l = content.split("////")
	var post = Post.instantiate()
	add_child(post)
	post.setup_post(l[0],l[1])

# Called when the node enters the scene tree for the first time.
func _ready():
	load_from_file()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
