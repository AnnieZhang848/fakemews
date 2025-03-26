class_name Character
extends Node2D

@onready var eye : AnimatedSprite2D = $Body/Eyes
@onready var mouth : AnimatedSprite2D = $Body/Mouths
var faces = {}
var cur_face 

# Save preset faces to a dictionary with a name (key) and an eye + mouth frame pair (value)
func add_face(n, eyes, mouth_open, mouth_closed):
	faces[n] = Vector3(eyes, mouth_open, mouth_closed)

# Apply a preset face to the character
func set_face(n):
	if n in faces:
		cur_face = n
		eye.frame = faces[n][0]
		mouth.frame = faces[n][1]
	else:
		cur_face = "ERROR"
		eye.frame = faces["ERROR"][0]
		mouth.frame = faces["ERROR"][1]

func close_mouth():
	mouth.frame = faces[cur_face][2]

# Set eyes/mouth manually
func set_eyes(e):
	eye.frame = e

func set_mouth(m):
	mouth.frame = m
