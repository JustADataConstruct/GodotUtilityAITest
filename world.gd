extends Node3D

@onready var agent = $Agent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_show_window_button_pressed():
	$Node/DebugWindow.show()
