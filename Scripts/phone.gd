extends Control

var postList

# Called when the node enters the scene tree for the first time.
func _ready():
	postList = {
		"Ad Hominem" : $Screen/AdHominem,
		"Appeal to Authority" : $Screen/AppealToAuthority,
		"Slippery Slope" : $Screen/SlipperySlope,
		"Hasty Generalization" : $Screen/HastyGeneralization,
		"Red Herring" : $Screen/RedHerring
	}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_char(whichChar):
	if whichChar == "Evan":
		$EvanPhone.show()
		$LeahPhone.hide()
	else:
		$EvanPhone.hide()
		$LeahPhone.show()

func set_post(post):
	for p in postList:
		postList[p].hide()
	postList[post].show()
