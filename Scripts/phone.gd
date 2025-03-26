extends Control

@onready var Post = preload("res://Objects/Posts/BasePost.tscn")
@onready var Selection = preload("res://Objects/Selection.tscn")

var Options = ["res://FallacyOptions/Example1.txt"]
var SelectionScreen

func load_from_file(index : int = 0):
	if index < 0 or FileAccess.file_exists(Options[index]) == false:
		print("Error loading from index: %s" % index)
		return
	var file = FileAccess.open(Options[0],FileAccess.READ)
	var content = file.get_as_text()
	clean_text(content)

func clean_text(content : String):
	var l = content.split("////")
	l[1] = l[1].strip_edges()
	#print(l[1].is_absolute_path())
	#var post = load(l[1])
	#post.instantiate()
	#add_child(post)
	#var post = Post.instantiate()
	#add_child(post)
	#post.setup_post(l[0],l[1])
	
	var options = l[2].split("????")
	SelectionScreen.SetPossibleText(options)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	
	SelectionScreen = Selection.instantiate()
	add_child(SelectionScreen)
	SelectionScreen.visible = false
	load_from_file()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_trybutton_button_up():
	SelectionScreen.visible = !SelectionScreen.visible
	pass # Replace with function body.
