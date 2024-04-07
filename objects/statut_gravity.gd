extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var Global = get_node("/root/Global")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("close_dialog"):
		get_tree().change_scene_to_file("res://objects/niv_"+str(Global.current_level)+".tscn")
