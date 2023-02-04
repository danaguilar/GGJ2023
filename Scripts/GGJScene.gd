extends Node

signal paused(isPaused)
onready var HUD = $"../HUD"

var isPaused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		isPaused = !isPaused
		HUD.SetPause(isPaused)
		get_tree().paused = isPaused
