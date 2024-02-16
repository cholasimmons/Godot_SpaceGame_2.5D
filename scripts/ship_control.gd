extends CharacterBody3D

signal laser_shot(laser_scene, location)

@onready var muzzle = $Muzzle

var max_speed = 22.0 # Ship's top speed
var acceleration = 8.0  # Gradual acceleration value
var turn_acceleration = 64.0 # Ship's rotation quickness
var laser_scene = preload("res://scenes/ship_3d_missile.tscn")
var shoot_cooldown := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cooldown:
			shoot_cooldown = true
			shoot()
			await get_tree().create_timer(0.2).timeout
			shoot_cooldown = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# var direction = Vector3(Input.get_axis("flip_left", "flip_right"), 0, Input.get_axis("ui_up", "ui_down"))
	
	# Calculate movement direction based on rotation
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("flip_left"):
		#flip_ship("left")
		direction -= (transform.basis.x)  # Move left (relative to ship's facing)
	elif Input.is_action_pressed("flip_right"):
		#flip_ship("right")
		direction += (transform.basis.x)  # Move right
	if Input.is_action_pressed("ui_up"):
		direction -= transform.basis.z  # Move forward
	elif Input.is_action_pressed("ui_down"):
		direction += transform.basis.z  # Move backward
	
	# Acceleration in the ship's forward direction
	var target_velocity = transform.basis.z * max_speed  # Forward direction 

	# Acceleration
	if direction.length() > 0:  # Accelerate only if moving 
		target_velocity = direction.normalized() * max_speed 
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
	# velocity += direction.normalized() * acceleration * delta
	# velocity = velocity.clamp(Vector3(0,0,-max_speed), Vector3(0,0,max_speed))  # Limit to max speed

	move_and_slide()

	# Rotate based on current Y-axis position (adjust sensitivity as needed)
	var target_turn_speed = 0.0
	if Input.is_action_pressed("ui_left"):
		target_turn_speed = turn_acceleration * delta
	elif Input.is_action_pressed("ui_right"):
		target_turn_speed = -turn_acceleration * delta
	else:
		target_turn_speed = 0.0  # Reset target speed when no turn keys pressed

	# Gradual rotation build-up (Corrected Approach)
	var turn_amount = 0.0
	turn_amount += (target_turn_speed - turn_amount) * turn_acceleration * delta

	# Apply rotation
	rotate_y(turn_amount * delta)  # Multiply by delta for smooth rotation

func shoot():
	laser_shot.emit(laser_scene, muzzle.global_position)

func flip_ship(dir):
	var rot
	if dir == 'left':
		rot = 0.01
	else:
		rot = -0.01
	rotate_z(rot)
