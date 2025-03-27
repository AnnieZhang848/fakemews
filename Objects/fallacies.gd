extends Control

var selected
@onready var List = $FallacyList
@onready var disc = $Description/DescriptionText

var FallacyDict = {"Ad Hominem":"Ad Hominem EX","Slipper Slope":"Slippery Slope Ex", "Appeal to Authority":"Appeal to Authority Ex","Appeal to Pity":"Appeal To Pity Ex","Hasty Generalization":"Hasty Ex","Red Hearring":"Red Hearring Ex"}
var unlocks = ["Ad Hominem","Slipper Slope","Appeal to Authority","Appeal to Pity","Hasty Generalization","Red Hearring"]
var base_unlocks = 3 

# Called when the node enters the scene tree for the first time.
func _ready():
	for n in range(base_unlocks):
		var e = unlocks[n]
		List.add_item(e)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_fallacy_list_item_clicked(index, at_position, mouse_button_index):
	selected = index; 
	disc.text = FallacyDict[unlocks[index]]
	
	
