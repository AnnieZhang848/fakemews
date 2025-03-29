extends Control

var FallacySelected
var TextSelected

signal correct_answer

@onready var FallacyList = $FallacyList
@onready var TextSelection = $Selection/OptionText
@onready var DownButton = $Selection/Down
@onready var UpButton = $Selection/Up

var PossibleText = [""]
var index = 0

var IdealFallacy = ""
var IdealText = ""

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

###For Setting possible sentences to indentify as fallacies ----- GIVE AN ARRAY OF STRING ONLY [split("????")]
#func SetPossibleText(PT):
	#PossibleText = PT
	#SetOptionText()
#
###Set correct asnwer for Falacy (EX: Strawman) and for the correct sentence
#func IdealAnswer(Fal,text):
	#IdealFallacy = Fal.strip_edges()
	#IdealText = text.strip_edges()


##Sets up the Selection Screen. Supply with numUnlocks, array of Unlocks, and filename of the example used
func PresentOptions(numUnlocks : int, unlocks, File : String):
	var rand = RandomNumberGenerator.new()
	var opt = []
	
	load_from_file(File)
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
	var a = (PossibleText[index].contains(IdealText)) and (FallacySelected.contains(IdealFallacy))
	print(a)
	#if a:
	emit_signal("correct_answer")
