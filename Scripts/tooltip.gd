class_name Tooltip
extends Control

@onready var hint = $Image/MainText

# Called when the node enters the scene tree for the first time.
func init(hintText):
	hint.text = hintText

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		queue_free()
