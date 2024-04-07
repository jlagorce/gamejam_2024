extends Area2D


var player
var canvas
var label

func _ready():
	player = get_tree().get_root().get_node("monde/player")
	
	canvas = $CanvasLayer
	canvas.hide()
	
	if has_meta("text"):
		$CanvasLayer/RichTextLabel.set_text(get_meta("text"))

func set_text(text):
	$CanvasLayer/RichTextLabel.set_text(text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if canvas.visible and Input.is_action_just_pressed("close_dialog"):
		canvas.hide()

func _on_body_entered(body):
	if body == player:
		canvas.show()

func _on_body_exited(body):
	if body == player:
		canvas.hide()
