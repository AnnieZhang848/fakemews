extends Control

var FallacySelected
var TextSelected
@onready var FallacyList = $FallacyList
@onready var TextSelection = $Selection/OptionText

var PossibleText = [""]
var index = 0

var IdealFallacy = ""
var IdealText = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
		var r=  rand.randi_range(0,numUnlocks)
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
	index = (1 + index) % PossibleText.size()
	SetOptionText()


func _on_down_button_up():
	index -= 1
	if index < 0:
		index = PossibleText.size() - 1
	SetOptionText()


func _on_confirm_button_up():
	#print(PossibleText[index])
	#print(IdealText)
	var a = (PossibleText[index].contains(IdealText)) and (FallacySelected.contains(IdealFallacy))
	print(a)
	pass # Replace with function body.
