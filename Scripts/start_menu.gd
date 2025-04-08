extends Control

signal game_start
signal level_select(n1, n2)

func _on_start_pressed() -> void:
	$BackgroundMusic.stop()
	hide()
	game_start.emit()

func _on_level_select_pressed() -> void:
	$Selection.show()

func _on_item_list_item_selected(index: int) -> void:
	match index:	
		0:
			level_select.emit(0, index)
		1:
			level_select.emit(3, index)
		2:
			level_select.emit(6, index)
		3:
			level_select.emit(9, index)
		4:
			level_select.emit(12, index)
	$BackgroundMusic.stop()
	hide()


func _on_back_button_up():
	$Selection.hide()
	#pass # Replace with function body.
