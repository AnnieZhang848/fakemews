extends Control

var teacher
var friend1
var friend2

var characters = {}
var speaker
var name_tag : Label
var dialogue : RichTextLabel

@export var scene_list = ["Scene1"]
#@export var scene_list = ["Friend1_Expressions","Friend2_Expressions","Teacher_Expressions"]
var cur_scene = 0
var scene_text : Array
var cur_text = 0
var textBoxes = {
	"Teacher" : load("res://Assets/f1_dialogue.png"),
	"Friend1" : load("res://Assets/m1_dialogue.png"),
	"Ava" : load("res://Assets/f2_dialogue.png"),
	"Player" : load("res://Assets/p_dialogue.png")
}

signal scene_started(bg : String)
signal scene_ended(scene_num : int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init()
	load_from_file(cur_scene)
	
func init():
	name_tag = $TextBox/Name
	dialogue = $TextBox/Dialogue
	
	teacher = $Characters/Teacher
	friend1 = $Characters/Male1
	friend2 = $Characters/Ava
	
	characters["Teacher"] = teacher
	characters["Friend1"] = friend1
	characters["Ava"] = friend2

func load_from_file(index : int = 0):
	var filename = "res://Dialogue/%s.txt" % scene_list[index]
	if index < 0 or FileAccess.file_exists(filename) == false:
		print("Error loading from index: %s" % index)
		return
	var file = FileAccess.open(filename,FileAccess.READ)
	var content = file.get_as_text().rstrip("\n")
	scene_text = content.split("\n")
	set_speaker(scene_text.pop_front())
	scene_started.emit(scene_text.pop_front().rstrip("\n"))
	
	set_text(scene_text[cur_text])
	file.close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Next_Text") and get_parent().visible:
		next_text()

func _on_next_button_pressed() -> void:
	next_text()

func set_speaker(n):
	if speaker != null:
		speaker.hide()
	speaker = characters[n]
	speaker.show()
	name_tag.text = n
	$TextBox.texture = textBoxes[n]

func set_text(s):
	var text = s.split(" : ")
	if text[0] == "P":
		name_tag.hide()
		speaker.close_mouth()
		$TextBox.texture = textBoxes["Player"]
	else:
		name_tag.show()
		speaker.set_face(text[0])
		$TextBox.texture = textBoxes[characters.find_key(speaker)]
	dialogue.text = text[1]

func next_text():
	if cur_text < len(scene_text)-1:
		cur_text += 1
		set_text(scene_text[cur_text])
	else:
		scene_ended.emit(cur_scene)
		cur_scene += 1
		if cur_scene < len(scene_list):
			cur_text = 0
			load_from_file(cur_scene)
