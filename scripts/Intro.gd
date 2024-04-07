extends CanvasLayer

var TexteIntro
var VoixOff
var floatScroll = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	TexteIntro = get_node("ScrollContainer")
	VoixOff = get_node("AudioStreamPlayer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	floatScroll += 0.8	
	TexteIntro.scroll_vertical = int(floatScroll)
	if not VoixOff.is_playing() or Input.is_action_just_pressed("dash"):
		get_tree().change_scene_to_file("res://objects/niv_1.tscn")
