extends Node3D

@onready var ship_spawn_pos = $ShipSpawnPos;
@onready var laser_container = $LaserContainer;

var player = null;


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("ship")
	assert(player!=null)
	player.global_position = ship_spawn_pos.global_position
	player.laser_shot.connect(_on_player_laser_shot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)

func _on_area_3d_area_entered(area):
	print("area entered")
	print(area)
