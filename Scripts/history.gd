extends Control

@onready var textBox = $ScrollContainer/VBoxContainer
var max_scroll_length = 0 
@onready var scrollbar = $ScrollContainer.get_v_scroll_bar()

func _ready(): 
	scrollbar.changed.connect(handle_scrollbar_changed)
	max_scroll_length = scrollbar.max_value

func handle_scrollbar_changed(): 
	if max_scroll_length != scrollbar.max_value: 
		max_scroll_length = scrollbar.max_value 
		$ScrollContainer.scroll_vertical = max_scroll_length

func add_text(textArray):
	var dialogueLine = RichTextLabel.new()
	dialogueLine.fit_content = true
	dialogueLine.text = "%s: %s" % textArray
	dialogueLine.theme = load("res://Assets/GameTheme.tres")
	dialogueLine.bbcode_enabled = true
	textBox.add_child(dialogueLine)
