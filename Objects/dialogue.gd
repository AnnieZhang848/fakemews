extends Control

var teacher
var friend1
var friend2

var characters = {}
var speaker
var name_tag : Label
var dialogue : RichTextLabel

var textFiles = ["res://Dialogue/Scene1.txt","res://Dialogue/Scene2.txt"]
var cur_scene = 0
var scene_text : Array
var cur_text = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init()
	load_from_file(cur_scene)

func load_from_file(index : int = 0):
	if index < 0 or FileAccess.file_exists(textFiles[index]) == false:
		print("Error loading from index: %s" % index)
		return
	var file = FileAccess.open(textFiles[index],FileAccess.READ)
	var content = file.get_as_text().rstrip("\n")
	scene_text = content.split("\n")
	set_speaker(scene_text.pop_front())
	
	set_text(scene_text[cur_text])
	file.close()

func init():
	name_tag = $TextBox/Name
	dialogue = $TextBox/Dialogue
	
	teacher = $Characters/Female1
	friend1 = $Characters/Male1
	friend2 = $Characters/Female2
	
	characters["Teacher"] = teacher
	characters["Friend1"] = friend1
	characters["Friend2"] = friend2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_speaker(n):
	if speaker != null:
		speaker.hide()
	speaker = characters[n]
	speaker.show()
	name_tag.text = n

func set_text(s):
	var text = s.split(" : ")
	if text[0] == "P":
		name_tag.hide()
		# Change other stuff visually to indicate player thoughts
	else:
		#name_tag.show()
		speaker.set_face(text[0])
	dialogue.text = text[1]

func _on_next_button_pressed() -> void:
	if cur_text < len(scene_text)-1:
		cur_text += 1
		set_text(scene_text[cur_text])
	else:
		cur_scene += 1
		if cur_scene < len(textFiles):
			cur_text = 0
			load_from_file(cur_scene)
			#set_speaker(speakers[cur_scene])
