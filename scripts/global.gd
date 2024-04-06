extends Node

const X_POS_NIV1 = 1058.82
const Y_POS_NIV1 = 101.513
const X_POS_NIV2 = 606.181
const Y_POS_NIV2 = 226.911
const X_POS_NIV3 = 1022.93
const Y_POS_NIV3 = -75.637

var current_level = 1
var power = ""
var parent = null
var in_transition = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(current_level)
	if in_transition == false:
		for node in parent:
			if node.name == "ambiance":
				if node.has_stream_playback() == false:
					node.play()
	
