extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var Global = get_node("/root/Global")
	Global.parent = get_tree().get_root().get_child(1).get_children()
	Global.in_transition = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
