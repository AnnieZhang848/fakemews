extends Control

@export var numUnlocks = 3 
var unlocks = ["Ad Hominem","Slippery Slope","Appeal to Authority","Appeal to Pity","Hasty Generalization","Red Herring"]
var FileOptions = ["res://FallacyOptions/Example1.txt"]

@onready var FallacyNotes = $Fallacies
@onready var Select = $Game/Selection

func _process(delta):
	pass

func _ready():
	SetSelectionScreen()
	FallacyNotes.unlocks = unlocks
	FallacyNotes.numUnlocks = 3
	FallacyNotes.init()

func SetSelectionScreen(index : int = 0):
	Select.PresentOptions(numUnlocks,unlocks,FileOptions[index])

func incrementUnlocks():
	FallacyNotes.incrementUnlocks()
	numUnlocks +=1

# When a scene ends, check what it should be followed by and show the correct scene
func _on_game_scene_ended(scene_num: Variant) -> void:
	pass

func _on_open_notes_pressed() -> void:
	$Fallacies.show()
	$Game.hide()

func _on_close_notes_pressed() -> void:
	$Fallacies.hide()
	$Game.show()

func _on_dialogue_scene_started(bg: String) -> void:
	$Background.texture = load("res://Assets/Backgrounds/%s" % bg)
