extends CharacterBody2D

# Constantes
# Mouvement
# Bases
const SPEED = 30000
const JUMP_VELOCITY = 36000
# Double saut
const TIME_DOUBLE_JUMP = 0.1
const TIME_ENTER_JUMP = 1
const NB_JUMP = 1
# Dash
const DASH_VELOCITY = 1500000
# Gravity
const TIME_GRAVITY_SWITCH = 3

const TIME_SWITCH_WORLD = 3

var pouvoir = ""
# Variables
# Gravity
var gravity_orient = 1
var timer_gravity_switch = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var tile_map = null

var pas = null

# Monde
var timer_switch_world = -1

# Mouvements
# Double saut
var jump_remaining = 1
var timer_double_jump = -1
var timer_jump = -1
# Dash
var dash_remain = 1
var Sprite
# Called when the node enters the scene tree for the first time.
func _ready():
	var Global = get_node("/root/Global")
	Sprite = get_node("AnimatedSprite2D")
	tile_map = get_tree().get_root().get_node("monde/TileMap")
	for node in get_children():
		if node.name == "pas":
			pas = node
	world_power()

func _physics_process(delta):
	manage_moves(delta)
	check_death()
	move_and_slide()
	animation()

func animation():
	if is_on_floor():
		if velocity.x != 0:
			Sprite.play("Run")
	if velocity.x > 0:
		Sprite.scale.x = 4
	elif velocity.x < 0:
		Sprite.scale.x = -4
		
func gravity_power():
	pouvoir = "gravity"
	
func world_power():
	pouvoir = "world"
	
func movement_power():
	pouvoir = "movement"

func manage_moves(delta):
	manage_gravity(delta)
	manage_side_moves(delta)
	match Global.power:
		"gravity":
			manage_switch_gravity(delta)
			manage_jump(delta)
		"world":
			switch_world(delta)
			manage_jump(delta)
		"movement":
			manage_double_jump(delta)
			manage_dash(delta)
		_:
			manage_jump(delta)

func manage_jump(delta):
	if Input.get_action_strength("ui_up") == 1:
		if (is_on_floor() or is_on_ceiling()) and timer_jump <= 0:
			update_y_velocity(delta)
			timer_jump = TIME_ENTER_JUMP/delta
	elif timer_jump > 0:
		timer_jump -= 1
		
func manage_double_jump(delta):
	if Input.get_action_strength("ui_up") == 1:
		if is_on_floor():
			update_y_velocity(delta)
			timer_double_jump = TIME_DOUBLE_JUMP/delta
			jump_remaining = NB_JUMP
		elif timer_double_jump <= 0 and jump_remaining > 0:
			velocity.y = 0
			update_y_velocity(delta)
			jump_remaining -= 1
	elif timer_double_jump > 0:
		timer_double_jump -= 1

func update_y_velocity(delta):
	velocity.y -= JUMP_VELOCITY * gravity_orient * delta

func switch_world(delta):
	if Input.is_action_just_pressed("switch_world"):
		tile_map.set_layer_enabled(2, not tile_map.is_layer_enabled(2))
		tile_map.set_layer_enabled(3, not tile_map.is_layer_enabled(3))
		timer_switch_world = TIME_SWITCH_WORLD/delta
	elif timer_switch_world > 0:
		timer_switch_world -= 1
		
func manage_gravity(delta):
	velocity.y += gravity * gravity_orient * delta

func manage_side_moves(delta):
	velocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))*delta*SPEED
	if velocity.x != 0 and (is_on_floor() or is_on_ceiling()):
		if not pas.has_stream_playback():
			pas.play()
	else:
		pas.stop()
	
func manage_dash(delta):
	if Input.get_action_strength("dash") == 1 and dash_remain > 0:
		if velocity.x > 0:
			velocity.x += DASH_VELOCITY * delta
			dash_remain -= 1
		elif velocity.x < 0:
			velocity.x -= DASH_VELOCITY * delta
			dash_remain -= 1
	if is_on_floor():
		dash_remain = 1

func manage_switch_gravity(delta):
	if Input.is_action_just_pressed("switch_gravity") and is_on_floor():
		velocity.y = 0
		gravity_orient *= -1
		timer_gravity_switch = TIME_GRAVITY_SWITCH/delta
	elif gravity_orient == -1 and timer_gravity_switch <= 0:
		velocity.y = 0
		gravity_orient *= -1
	elif timer_gravity_switch > 0:
		timer_gravity_switch -= 1

func respawn_player():
	if Global.current_level == 1:
		position.x = Global.X_POS_NIV1
		position.y = Global.Y_POS_NIV1
	elif Global.current_level == 2:
		position.x = Global.X_POS_NIV2
		position.y = Global.Y_POS_NIV2
	elif Global.current_level == 3:
		position.x = Global.X_POS_NIV3
		position.y = Global.Y_POS_NIV3

func check_death():
	if position.y > 5000 or Input.get_action_strength("respawn") == 1:
		respawn_player()
