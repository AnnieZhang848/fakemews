extends Control

signal gameStart

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_game():
	$AnimationPlayer.play("fly_in")

func _on_next_button_pressed() -> void:
	hide()
	gameStart.emit()
