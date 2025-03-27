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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
##GIVE AN ARRAY OF STRING ONLY 
func SetPossibleText(PT):
	PossibleText = PT
	SetOptionText()
	
func IdealAnswer(Fal,text):
	IdealFallacy = Fal.strip_edges()
	IdealText = text.strip_edges()

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
