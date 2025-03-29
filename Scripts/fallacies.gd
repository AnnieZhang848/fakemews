extends Control

var selected
@onready var List = $FallacyList
@onready var disc = $Description/DescriptionText

@export var unlocks = []
@export var numUnlocks = 0

var FallacyDict = {"Ad Hominem":"Ad Hominem EX","Slippery Slope":"Slippery Slope Ex", "Appeal to Authority":"Appeal to Authority Ex","Appeal to Pity":"Appeal To Pity Ex","Hasty Generalization":"Hasty Ex","Red Herring":"Red Herring Ex"}

# Called when the node enters the scene tree for the first time.
func init():
	for n in range(numUnlocks):
		var e = unlocks[n]
		List.add_item(e)
		
func incrementUnlocks():
	numUnlocks += 1
	List.add_item(unlocks[numUnlocks])

func numFallacyUnlocked():
	return numUnlocks

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_fallacy_list_item_clicked(index, at_position, mouse_button_index):
	selected = index; 
	disc.text = FallacyDict[unlocks[index]]
	
	
