extends Control

var FallacySelected
var TextSelected
@onready var FallacyList = $FallacyList
@onready var TextSelection = $Selection/OptionText
var PossibleText = [""]


var index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
	
	
	
	
##GIVE AN ARRAY OF STRING ONLY 
func SetPossibleText(PT):
	PossibleText = PT
	SetOptionText()

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
	print(PossibleText[index])
	print(FallacySelected)
	
	pass # Replace with function body.
