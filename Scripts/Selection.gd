extends Control

var FallacySelected

signal correct_answer
signal post_set(post : String)

@onready var FallacyList = $Part2/FallacyList
@onready var Phone = $Part2/Phone
@onready var TextSelection = $Part1/OptionText
@onready var DownButton = $Part1/Down
@onready var UpButton = $Part1/Up
@onready var Hint3 = $Part2/Hint3
var hints : bool = true

var FileOptions = ["AdHominem", "AppealToAuthority", "SlipperySlope", "HastyGeneralization", "RedHerring"]

var PossibleText = [""]
var index = 0

var IdealFallacy = ""
var IdealText = ""

func _ready() -> void:
	enableHints()

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if is_visible():
		if Input.is_action_just_released("choice_up") and UpButton.is_visible():
			_on_up_button_up()
		if Input.is_action_just_released("choice_down") and DownButton.is_visible():
			_on_down_button_up()

##Sets up the Selection Screen. Supply with numUnlocks, array of Unlocks, and filename of the example used
func PresentOptions(numUnlocks : int, unlocks, File : int):
	FallacyList.clear()
	IdealFallacy = ""
	IdealText = ""
	index = 0
	FallacySelected = null
	SetTextScrollButton(true)
	
	var rand = RandomNumberGenerator.new()
	var opt = []
	
	load_from_file(FileOptions[File])
	SetOptionText()
	
	while (opt.size() < 3):
		var r = rand.randi_range(0,numUnlocks-1)
		if(opt.has(unlocks[r]) == false):
			opt.append(unlocks[r] as String)

	if(opt.has(IdealFallacy) == false):
		var r = rand.randi_range(0,2)
		opt[r] = IdealFallacy as String 	
		
	for o in opt:
		FallacyList.add_item(o)

func load_from_file(fileName : String):
	var file = "res://FallacyOptions/%s.txt" % fileName
	var f = FileAccess.open(file,FileAccess.READ)
	var content = f.get_as_text()
	clean_text(content)

func clean_text(content : String):
	var split = content.split("////")	
	
	IdealFallacy = split[2].strip_edges()
	IdealText = split[1].strip_edges()
	
	$Part2/Phone.set_post(IdealFallacy)
	post_set.emit(IdealFallacy)
	
	PossibleText = []
	for s in split[0].split("????"):
		PossibleText.append("[center]%s[/center]" % s.strip_edges())

func enableHints():
	$Hint1.init("Use the up and down arrows to select the part of the text that contains a LOGICAL FALLACY")
	$Hint1.show()
	$Hint2.init("When you think you have the answer, press this submit button")
	$Hint2.show()
	Hint3.init("Identify which fallacy is present and click the correct answer")
	Hint3.hide()

func SetTextScrollButton(b:bool):
	if b:
		$Part1/Up.hide()
		$Part1/Down.show()
	else:
		$Part1/Up.hide()
		$Part1/Down.hide()

###BUTTONS
func _on_fallacy_list_item_clicked(index, at_position, mouse_button_index):
	FallacySelected = FallacyList.get_item_text(index)
	if FallacySelected.contains(IdealFallacy):
		index = 0
		FallacySelected = ""
		Phone.show()
		$Confirm.show()
		correct_answer.emit()
	else:
		$ErrorDialogueBox.visible = true

func SetOptionText():
	TextSelection.text = PossibleText[index]

func _on_up_button_up():
	index -= 1
	ButtonIndexCheck()
	SetOptionText()

func _on_down_button_up():
	index += 1		
	ButtonIndexCheck()
	SetOptionText()

func ButtonIndexCheck():
	if index == 0:
		UpButton.hide()
	else:
		UpButton.show()
	if index == PossibleText.size() - 1:
		DownButton.hide()
	else:
		DownButton.show()

func _on_confirm_button_up():
	if PossibleText[index].contains(IdealText):
		$Confirm.hide()
		SetTextScrollButton(false)
		Phone.hide()
		if(hints == true):
			Hint3.show()
			hints = false
	else:
		$ErrorDialogueBox.visible = true

func _on_dialogue_button_button_up():
	$ErrorDialogueBox.visible = false
