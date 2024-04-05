extends CharacterBody2D

const SPEED = 30000
const JUMP_VELOCITY = 600
const TIME_ENTER_JUMP = 1

var timer_jump = 0
var gravity_orient = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	manage_moves(delta)
	move_and_slide()
	
func manage_moves(delta):
	manage_switch_gravity()
	manage_gravity(delta)
	manage_side_moves(delta)
	manage_jump(delta)

func manage_jump(delta):
	if Input.get_action_strength("ui_up") == 1 and timer_jump == 0 and is_on_floor():
		velocity.y -= JUMP_VELOCITY * gravity_orient
		timer_jump = TIME_ENTER_JUMP/delta
	elif timer_jump > 0:
		timer_jump -= 1

func manage_gravity(delta):
	velocity.y += gravity * gravity_orient * delta

func manage_side_moves(delta):
	velocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))*delta*SPEED

func manage_switch_gravity():
	if Input.is_action_just_released("switch_gravity"):
		gravity_orient *= -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
