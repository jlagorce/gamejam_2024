extends AnimatedSprite2D

var Global

var Frame = ["Normal", "Parallele"]
var NbFrame = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Global = get_node("/root/Global")
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	print(Global.power)
	if true or Global.power == "world":
		if Input.is_action_just_pressed("switch_world"):
			NbFrame=(NbFrame+1) % 2
			play(Frame[NbFrame])
