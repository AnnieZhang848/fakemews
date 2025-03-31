extends Control

var numUnlocks = 3
var unlocks = ["Ad Hominem", "Strawman", "Slippery Slope","Appeal to Authority","Hasty Generalization","Appeal to Pity","Red Herring"]
var selectionScreen = 0

@onready var Notes = $Fallacies
@onready var Dialogue = $Game/Dialogue
@onready var Select = $Game/Selection
@onready var OpenNotes = $Game/OpenNotes

func _ready():
	Dialogue.show()
	Select.hide()
	OpenNotes.hide()
	$AnimationPlayer.play("fade in")

func SetSelectionScreen():
	Select.PresentOptions(numUnlocks,unlocks,selectionScreen)
	selectionScreen += 1

func incrementUnlocks():
	Notes.incrementUnlocks()
	numUnlocks +=1
	
func _set_background(bg: String) -> void:
	$Background.texture = load("res://Assets/Backgrounds/%s" % bg)

# When a scene ends, check what it should be followed by and show the correct scene
func _on_game_scene_ended(scene_num: int) -> void:
	print(scene_num)
	match scene_num:
		0:
			Notes.init(unlocks, numUnlocks)
			OpenNotes.show()
			$AnimationPlayer.play("fade out")
			Dialogue.load_scene(scene_num+1)
			$AnimationPlayer.play("fade in")
			SetSelectionScreen()
		1,4,7,10,13:
			Select.show()
			Dialogue.hide()
		2,5,8,11:
			$AnimationPlayer.play("fade out")
			Dialogue.load_scene(scene_num+1)
			$AnimationPlayer.play("fade in")
			SetSelectionScreen()
		3,6,9,12:
			numUnlocks += 1
			Notes.incrementUnlocks()
			$AnimationPlayer.play("fade out")
			Dialogue.load_scene(scene_num+1)
			$AnimationPlayer.play("fade in")

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

func _on_dialogue_friend_talking(friend: String) -> void:
	$Game/Dialogue/Phone.set_char(friend)
	$Game/Selection/Part2/Phone.set_char(friend)

func _on_selection_post_set(post: String) -> void:
	$Game/Dialogue/Phone.set_post(post)
