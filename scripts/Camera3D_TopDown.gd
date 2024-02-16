extends Camera3D

@export var target : Node3D
@export var follow_smoothness = 5.0  # Adjust for desired camera lag

var deadzone_width = 200  # Half the width of the deadzone
var deadzone_height = 150 # Half the height of the deadzone
var camera_follow_speed = 5.0  # Adjust for desired smoothness

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		var target_position = target.global_transform.origin
		var camera_position = global_transform.origin

		# Follow only on X and Z axes
		camera_position.x = target_position.x
		camera_position.z = target_position.z

		# Smoothly move towards the target position
		global_transform.origin = global_transform.origin.move_toward(camera_position, follow_smoothness * delta)
