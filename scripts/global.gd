extends Node

var current_level = 1
var power = ""
var parent = null

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent().get_child(1).get_children()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for node in parent:
		if node.name == "ambiance":
			if node.has_stream_playback() == false:
				node.play()
