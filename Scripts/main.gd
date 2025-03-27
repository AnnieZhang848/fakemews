extends Control

var backgrounds = ["Scene1.png","Scene2.jpg"]

# When a scene ends, check what it should be followed by and show the correct scene
func _on_game_scene_ended(scene_num: Variant) -> void:
	pass

func _on_open_notes_pressed() -> void:
	$Fallacies.show()
	$Game.hide()

func _on_close_notes_pressed() -> void:
	$Fallacies.hide()
	$Game.show()

func _on_dialogue_scene_started(scene_num: Variant) -> void:
	var filename = "res://Assets/Backgrounds/%s" % $Game/Dialogue.scene_list[scene_num]
	if FileAccess.file_exists(filename + ".png"):
		$Background.texture = load(filename + ".png")
	else:
		$Background.texture = load(filename + ".jpg")
