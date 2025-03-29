extends Control

var numUnlocks = 3
var unlocks = ["Ad Hominem", "Strawman", "Slippery Slope","Appeal to Authority","Appeal to Pity","Hasty Generalization","Red Herring"]
var FileOptions = ["res://FallacyOptions/Example1.txt"]

@onready var Notes = $Fallacies
@onready var Dialogue = $Game/Dialogue
@onready var Select = $Game/Selection
@onready var OpenNotes = $Game/OpenNotes

var sceneList = ["class1","class2","class3","class4","class5"]
var sceneNum = 0

func _ready():
	Dialogue.show()
	Select.hide()
	OpenNotes.hide()
	#SetSelectionScreen()

func SetSelectionScreen(index : int = 0):
	Select.PresentOptions(numUnlocks,unlocks,FileOptions[index])

func incrementUnlocks():
	Notes.incrementUnlocks()
	numUnlocks +=1
	
func _set_background(bg: String) -> void:
	$Background.texture = load("res://Assets/Backgrounds/%s" % bg)

# When a scene ends, check what it should be followed by and show the correct scene
func _on_game_scene_ended(scene_num: int) -> void:
	match scene_num:
		0:
			Notes.init(unlocks, numUnlocks)
			OpenNotes.show()
		1:
			Dialogue.hide()
			Select.show()
		2:
			numUnlocks += 1
			Notes.incrementUnlocks()
		3:
			Dialogue.hide()
			Select.show()
		4:
			numUnlocks += 1
			Notes.incrementUnlocks()
		5:
			Dialogue.hide()
			Select.show()
		6:
			numUnlocks += 1
			Notes.incrementUnlocks()
		7:
			Dialogue.hide()
			Select.show()
		8:
			numUnlocks += 1
			Notes.incrementUnlocks()
		9:
			Dialogue.hide()
			Select.show()

# Open and close the notes page
func _on_open_notes_pressed() -> void:
	Notes.show()
	$Game.hide()

func _on_close_notes_pressed() -> void:
	Notes.hide()
	$Game.show()

func _on_selection_correct_answer() -> void:
	Dialogue.show()
	Select.hide()
