extends CharacterBody2D

# Constantes
# Mouvement
# Bases
const SPEED = 30000
const JUMP_VELOCITY = 36000
# Double saut
const TIME_DOUBLE_JUMP = 0.5
const NB_JUMP = 1
# Dash
const DASH_VELOCITY = 300000

# Variables
# Gravity
var gravity_orient = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Mouvements
var all_moves = false
# Double saut
var jump_remaining = 1
var timer_double_jump = -1

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
	manage_dash(delta)

func manage_jump(delta):
	if Input.get_action_strength("ui_up") == 1:
		if is_on_floor():
			update_y_velocity(delta)
			timer_double_jump = TIME_DOUBLE_JUMP/delta
			jump_remaining = NB_JUMP
		elif  timer_double_jump <= 0 and jump_remaining > 0 and all_moves == true:
			velocity.y = 0
			update_y_velocity(delta)
			jump_remaining -= 1
	elif timer_double_jump > 0:
		timer_double_jump -= 1

func update_y_velocity(delta):
	velocity.y -= JUMP_VELOCITY * gravity_orient * delta

func manage_gravity(delta):
	velocity.y += gravity * gravity_orient * delta

func manage_side_moves(delta):
	velocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))*delta*SPEED

func manage_dash(delta):
	if Input.get_action_strength("dash") == 1 and all_moves == true:
		if velocity.x > 0:
			velocity.x += DASH_VELOCITY * delta
		elif velocity.x < 0:
			velocity.x -= DASH_VELOCITY * delta

func manage_switch_gravity():
	if Input.is_action_just_released("switch_gravity"):
		gravity_orient *= -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
