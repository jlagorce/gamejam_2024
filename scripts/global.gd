extends Node


var respawn_position = Vector2.ZERO

var current_level = 1
var power = ""
var parent = null
var in_transition = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_transition == false:
		if parent != null:
			for node in parent:
				if node.name == "ambiance":
					if node.has_stream_playback() == false:
						node.play()
	
