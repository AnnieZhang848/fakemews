extends Control

var selected
@onready var List = $FallacyList
@onready var disc = $Description/DescriptionText

@export var unlocks = []
@export var numUnlocks : int

var FallacyDict = {
	"Ad Hominem":"Definition - Attacking the person making the argument instead of debating the argument itself.\n\nExample - You can't trust Bob's opinion on climate change; he looks like he never goes outside!",
	"Strawman":"Definition - Misrepresenting or oversimplifying someone’s argument to make it easier to attack.\n\nExample -\nPerson A: We should limit sugar in school lunches to improve health.\nPerson B: So, you think we should ban all sweets and make everyone miserable?",
	"Slippery Slope":"Definition - Arguing that an action will definitely lead to a chain of negative events without evidence.\n\nExample - If we allow students to redo one test, next they'll want to redo every test, and soon no one will ever study!", 
	"Appeal to Authority":"Definition - Claiming an authority figure’s expertise to support a claim, despite this expertise being irrelevant or overstated.\n\nExample - If you want to be healthy, you need to stop drinking coffee. I read it on a fitness blog.",
	"Appeal to Pity":"Definition - Trying to win an argument not with logic or facts, but by making you feel sorry for someone.\n\nExample - You should give me a passing grade on this exam because if I fail, I'll lose my scholarship and disappoint my family.",
	"Hasty Generalization":"Definition - Making a broad or sweeping conclusion based on very limited evidence.\n\nExample - That teen didn't apologize after bumping into me. Teenagers are so rude!",
	"Red Herring":"Definition - Mentioning misleading or irrelevant information to confuse and distract.\n\nExample -\nPerson A: I'm worried about all the bike thefts lately.\nPerson B: But overall crime rates have been going down. The streets are safe!"}

# Called when the node enters the scene tree for the first time.
func init(unlockList, num):
	unlocks = unlockList
	numUnlocks = num
	for n in range(numUnlocks):
		var e = unlocks[n]
		List.add_item(e)
		
func incrementUnlocks():
	numUnlocks += 1
	List.add_item(unlocks[numUnlocks-1])

func numFallacyUnlocked():
	return numUnlocks

func _on_fallacy_list_item_clicked(index, at_position, mouse_button_index):
	selected = index; 
	disc.text = FallacyDict[unlocks[index]]
	
func clear_text():
	disc.text = ""
	List.deselect_all()
