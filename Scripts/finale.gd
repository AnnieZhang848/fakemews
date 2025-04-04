extends Control

signal scene_started(bg : String)
signal gameOver

var Evan
var Leah

var characters = {}
var name_tag : Label
var dialogue : RichTextLabel

var scene_text : Array
var cur_text : int = 0
var textBoxes = {
	"Evan" : load("res://Assets/m1_dialogue.png"),
	"Leah" : load("res://Assets/f2_dialogue.png"),
	"Player" : load("res://Assets/p_dialogue.png")
}

var chosen = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init()
	
func init():
	name_tag = $TextBox/Name
	dialogue = $TextBox/Dialogue
	
	Evan = $Characters/Evan
	Leah = $Characters/Leah
	
	characters["Evan"] = Evan
	characters["Leah"] = Leah

func load_scene(f):
	var filename = "res://Dialogue/%s.txt" % f
	if FileAccess.file_exists(filename) == false:
		return
	
	var file = FileAccess.open(filename,FileAccess.READ)
	var content = file.get_as_text().rstrip("\n")
	scene_text = content.split("\n")
	scene_started.emit("schoolyard.jpg")
	
	set_text(scene_text[cur_text])
	file.close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("Next_Text") and is_visible():
		next_text()

func _on_next_button_pressed() -> void:
	next_text()

# Set the text box to the current speaker
func set_speaker(n):
	name_tag.text = n
	$TextBox.texture = textBoxes[n]

# Update the text/text boxes and update the speaker's expression
func set_text(s):
	var text = s.split(" : ")
	if text[0] == "P":
		name_tag.hide()
		Evan.close_mouth()
		Leah.close_mouth()
		$TextBox.texture = textBoxes["Player"]
		dialogue.text = text[1]
	else:
		name_tag.text = text[0]
		name_tag.show()
		$TextBox.texture = textBoxes[text[0]]
		Evan.set_face("neutral")
		Evan.close_mouth()
		Leah.set_face("neutral")
		Leah.close_mouth()
		characters[text[0]].set_face(text[1])
		dialogue.text = text[2]

# Switch the current text
func next_text():
	if cur_text < len(scene_text)-1:
		cur_text += 1
		set_text(scene_text[cur_text])
	else:
		if chosen:
			hide()
			gameOver.emit()
		else:
			$Choice.show()

func _on_for_pressed() -> void:
	chosen = true
	$Choice.hide()
	cur_text = 0
	load_scene("leah")

func _on_against_pressed() -> void:
	chosen = true
	$Choice.hide()
	cur_text = 0
	load_scene("evan")
