extends CanvasLayer


onready var pause = $Pause
onready var lifeBar = $TopBar/LifeBar
onready var time = $TopBar/TimeBar/Time

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		

func SetPause(var isPaused: bool):
	pause.visible = isPaused

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
