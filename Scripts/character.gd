class_name Character
extends Node2D

@onready var eye : AnimatedSprite2D = $Body/Eyes
@onready var mouth : AnimatedSprite2D = $Body/Mouths
var faces = {}

# Save preset faces to a dictionary with a name (key) and an eye + mouth frame pair (value)
func add_face(n, eyes, mouth):
	faces[n] = Vector2(eyes,mouth)

# Apply a preset face to the character
func set_face(n):
	eye.frame = faces[n][0]
	mouth.frame = faces[n][1]

# Set eyes/mouth manually
func set_eyes(e):
	eye.frame = e

func set_mouth(m):
	mouth.frame = m
