extends Control

@onready var textBox = $ScrollContainer/VBoxContainer

func add_text(textArray):
	var dialogueLine = RichTextLabel.new()
	dialogueLine.fit_content = true
	dialogueLine.text = "%s: %s" % textArray
	dialogueLine.theme = load("res://Assets/GameTheme.tres")
	textBox.add_child(dialogueLine)
