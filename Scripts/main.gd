extends Control

# When a scene ends, check what it should be followed by and show the correct scene
func _on_game_scene_ended(scene_num: Variant) -> void:
	pass

func _on_open_notes_pressed() -> void:
	$Fallacies.show()
	$Game.hide()

func _on_close_notes_pressed() -> void:
	$Fallacies.hide()
	$Game.show()
