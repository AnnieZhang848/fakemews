extends Control

var teacher
var friend1
var friend2

var characters = {}
var speaker
var name_tag : Label
var dialogue : RichTextLabel

@export var scene_list = ["Class1","Test1","Response1","Class2","Test2","Response2","Class3","Test3","Response3","Class4","Test4","Response4","Class5","Test5","Response5"]
#@export var scene_list = ["Friend1_Expressions","Friend2_Expressions","Teacher_Expressions"]
@export var cur_scene : int = 0
var scene_text : Array
var cur_text : int = 0
var textBoxes = {
	"Teacher" : load("res://Assets/f1_dialogue.png"),
	"Evan" : load("res://Assets/m1_dialogue.png"),
	"Leah" : load("res://Assets/f2_dialogue.png"),
	"Player" : load("res://Assets/p_dialogue.png")
}

signal scene_started(bg : String)
signal scene_ended(scene_num : int)
signal friend_talking(friend : String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init()
	#load_scene(cur_scene)
	
func init():
	name_tag = $TextBox/Name
	dialogue = $TextBox/Dialogue
	
	teacher = $Characters/Teacher
	friend1 = $Characters/Evan
	friend2 = $Characters/Leah
	
	characters["Teacher"] = teacher
	characters["Evan"] = friend1
	characters["Leah"] = friend2

func load_scene(index : int = cur_scene):
	if index > len(scene_list):
		return
	
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
	if cur_scene > 14:
		hide()
	if Input.is_action_just_released("Next_Text") and get_parent().is_visible() and is_visible():
		next_text()

func _on_next_button_pressed() -> void:
	next_text()

# Set the character sprite to the current speaker
func set_speaker(n):
	if speaker != null:
		speaker.hide()
	speaker = characters[n]
	speaker.show()
	name_tag.text = n
	$TextBox.texture = textBoxes[n]
	
	if n == "Evan" or n == "Leah":
		friend_talking.emit(n)

# Update the text/text boxes and update the speaker's expression
func set_text(s):
	if s == "PHONE":
		slide_char(false)
		$Phone.show()
		next_text()
	else:
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

# Switch the current text
# Switch the scene if needed
func next_text():
	if cur_text < len(scene_text)-1:
		cur_text += 1
		set_text(scene_text[cur_text])
	else:
		cur_text = 0
		scene_ended.emit(cur_scene)
		slide_char(true)
		$Phone.hide()
		cur_scene += 1

func slide_char(centered):
	if centered:
		$AnimationPlayer.play("slide_center")
	else:
		$AnimationPlayer.play("slide_right")
