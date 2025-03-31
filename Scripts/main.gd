extends Control

var numUnlocks = 3
var unlocks = ["Ad Hominem", "Strawman", "Slippery Slope","Appeal to Authority","Hasty Generalization","Appeal to Pity","Red Herring"]

@onready var Notes = $Fallacies
@onready var Dialogue = $Game/Dialogue
@onready var Select = $Game/Selection
@onready var OpenNotes = $Game/OpenNotes

func _ready():
	Dialogue.show()
	Select.hide()
	OpenNotes.hide()

func SetSelectionScreen(index : int = 0):
	Select.PresentOptions(numUnlocks,unlocks,index)

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
			Dialogue.load_scene(scene_num+1)
		1,4,7,10,13:
			SetSelectionScreen()
			Select.show()
			Dialogue.hide()
		2,5,8,11:
			Dialogue.load_scene(scene_num+1)
		3,6,9,12:
			numUnlocks += 1
			Notes.incrementUnlocks()
			Dialogue.load_scene(scene_num+1)

# Open and close the notes page
func _on_open_notes_pressed() -> void:
	Notes.show()
	$Game.hide()

func _on_close_notes_pressed() -> void:
	Notes.hide()
	Notes.clear_text()
	$Game.show()

func _on_selection_correct_answer() -> void:
	Dialogue.load_scene()
	Dialogue.show()
	Select.hide()
