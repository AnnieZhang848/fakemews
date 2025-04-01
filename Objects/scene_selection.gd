extends Control

signal scene_select(n1,n2)

var numScene = 0
var select = 0

func _ready():
	scene_select.connect(get_parent().get_parent()._on_scene_select)

func _on_item_list_item_selected(index):
	#0,2,5,8,11
	select = index
	match index:	
		0:
			numScene = 0
			#select = 0
		1:
			numScene = 2
			#select = 0
		2:
			numScene = 5
			#select = 0
		3:
			numScene = 8
			#select = 0	
		4:
			numScene = 11
			#select = 0
	


func _on_confirm_button_up():
	scene_select.emit(numScene,select)
	$Popup.show()
	print()
	$Popup.text = "%s will be played on start.\n (Click to Close)" % $ItemList.get_item_text(select)
	
	
	pass # Replace with function body.




func _on_popup_button_up():
	$Popup.hide()
	self.hide()
	pass # Replace with function body.
