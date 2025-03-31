extends Control

var FallacySelected

signal correct_answer

@onready var FallacyList = $Part2/FallacyList
@onready var Phone = $Part2/Phone
@onready var TextSelection = $Part1/OptionText
@onready var DownButton = $Part1/Down
@onready var UpButton = $Part1/Up
@onready var Hint3 = $Part2/Hint3

var FileOptions = ["res://FallacyOptions/RedHerring.txt"]

var PossibleText = [""]
var index = 0

var IdealFallacy = ""
var IdealText = ""

func _ready() -> void:
	$Hint1.init("Use the up and down arrows to select the part of the text that contains a LOGICAL FALLACY")
	$Hint2.init("When you think you have the answer, press this submit button")
	Hint3.init("Identify which fallacy is present. Then press the submit button again")

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if index == 0:
		UpButton.hide()
	else:
		UpButton.show()
		
	if index == PossibleText.size() - 1:
		DownButton.hide()
	else:
		DownButton.show()

##Sets up the Selection Screen. Supply with numUnlocks, array of Unlocks, and filename of the example used
func PresentOptions(numUnlocks : int, unlocks, File : int):
	FallacyList.clear()
	
	var rand = RandomNumberGenerator.new()
	var opt = []
	
	load_from_file(FileOptions[File])
	SetOptionText()
	
	while (opt.size() < 3):
		var r=  rand.randi_range(0,numUnlocks-1)
		if(opt.has(unlocks[r]) == false):
			
			opt.append(unlocks[r] as String)

	if(opt.has(IdealFallacy) == false):
		var r = rand.randi_range(0,2)
		opt[r] = IdealFallacy as String 	
		
	for o in opt:
		FallacyList.add_item(o)

func load_from_file(file : String):
	if FileAccess.file_exists(file) == false:
		print("Error loading from index: %s" % index)
		return
	var f = FileAccess.open(file,FileAccess.READ)
	var content = f.get_as_text()
	clean_text(content)

func clean_text(content : String):
	var split = content.split("////")	
	
	IdealFallacy = split[2].strip_edges()
	IdealText = split[1].strip_edges()
	
	PossibleText = []
	for s in split[0].split("????"):
		PossibleText.append(s.strip_edges())
		
func _on_fallacy_list_item_clicked(index, at_position, mouse_button_index):
	FallacySelected = FallacyList.get_item_text(index)

func SetOptionText():
	TextSelection.text = PossibleText[index]

func _on_up_button_up():
	index -= 1
	SetOptionText()

func _on_down_button_up():
	index += 1
	SetOptionText()

func _on_confirm_button_up():
	if PossibleText[index].contains(IdealText):
		if FallacySelected == null:
			Phone.hide()
			Hint3.show()
		elif FallacySelected.contains(IdealFallacy):
			index = 0
			correct_answer.emit()
	
