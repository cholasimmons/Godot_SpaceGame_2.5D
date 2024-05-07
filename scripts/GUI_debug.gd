extends Control

@onready var HUD = "."
@onready var visibility_btn = $MarginContainerL/VBoxContainer/disable_btn
@onready var multiplier_label = $MarginContainerL/VBoxContainer/HBoxContainer/shipThrust_value

signal visibility_btn_pressed()

var multiplier_value: int = 2;

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the physics script node
	multiplier_label.text = str(multiplier_value)
	
	# pass; # multiplier_label.connect("acceleration_updated", self, "_on_acceleration_updated")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;

func _on_acceleration_updated(multiplier):
	# Update your UI here, e.g., update a Label node's text
	print(multiplier)
	multiplier_label.text = str(multiplier)


func _on_disable_btn_pressed():
	print("Button pressed")
