extends Area3D

@export var speed = 16

var ship = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# ship = get_tree().get_first_node_in_group("ship")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position.z += -speed * delta


func _on_visible_on_screen_notifier_3d_screen_exited():
	print("Missile exited")
	queue_free()
