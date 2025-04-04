extends Control

var numUnlocks = 3
var unlocks = ["Ad Hominem", "Strawman", "Slippery Slope","Appeal to Authority","Hasty Generalization","Appeal to Pity","Red Herring"]
var selectionScreen = 0

@onready var Notes = $Fallacies
@onready var Dialogue = $Game/Dialogue
@onready var Select = $Game/Selection
@onready var Finale = $Game/Finale
@onready var OpenNotes = $Game/OpenNotes
@onready var BGM = $BackgroundMusic

var music = {
	"Teacher" : "res://Assets/Sounds/Teacher.ogg",
	"Evan" : "res://Assets/Sounds/Evan.ogg",
	"Leah" : "res://Assets/Sounds/Teacher.ogg"
}

func _ready():
	Select.hide()
	OpenNotes.hide()

func SetSelectionScreen():
	Select.PresentOptions(numUnlocks,unlocks,selectionScreen)
	selectionScreen += 1

func incrementUnlocks():
	Notes.incrementUnlocks()
	numUnlocks += 1
	
func _set_background(bg: String) -> void:
	$Background.texture = load("res://Assets/Backgrounds/%s" % bg)

# When a scene ends, check what it should be followed by and show the correct scene
func _on_game_scene_ended(scene_num: int) -> void:
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
			switch_music("Teacher")
			Dialogue.load_scene(scene_num+1)
			$AnimationPlayer.play("fade in")
			SetSelectionScreen()
		3,6,9,12:
			numUnlocks += 1
			Notes.incrementUnlocks()
			$AnimationPlayer.play("fade out")
			Dialogue.load_scene(scene_num+1)
			$AnimationPlayer.play("fade in")
		14:
			$AnimationPlayer.play("fade out")
			switch_music("teacher")
			Finale.load_scene("finale")
			$AnimationPlayer.play("fade in - finale")

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
	switch_music(friend)

func _on_selection_post_set(post: String) -> void:
	$Game/Dialogue/Phone.set_post(post)

func switch_music(f):
	var file = load("res://Assets/Sounds/%s.ogg" % f)
	if BGM.stream != file:
		BGM.stream = file
		BGM.play()

func _on_start_menu_game_start() -> void:
	Dialogue.hide()
	$Intro.show()
	$Intro.start_game()
	
func _on_start_menu_level_select(n1: Variant, n2: Variant) -> void:
	numUnlocks = 3
	Notes.init(unlocks, numUnlocks)
	OpenNotes.show()
	selectionScreen = n2
	Dialogue.cur_scene = n1
	for i in range(n2-1):
		incrementUnlocks()
	SetSelectionScreen()
	_on_intro_game_start()

func _on_finale_game_over() -> void:
	$AnimationPlayer.speed_scale = 0.5
	$AnimationPlayer.play("fade out")
	_set_background("endScreen.png")
	switch_music("Menu")
	$Game.hide()
	$Fallacies/CloseNotes.hide()
	$AnimationPlayer.play("fade in - ending")
	Notes.show()

func _on_intro_game_start() -> void:
	$AnimationPlayer.play("fade in")
	switch_music("Teacher")
	Dialogue.load_scene()
