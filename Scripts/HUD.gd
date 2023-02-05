extends CanvasLayer


onready var pause = $Pause
onready var lifeBar = $TopBar/LifeBar/HBoxContainer
onready var time = $TopBar/TimeBar/Time

func SetPause(var isPaused: bool):
	pause.visible = isPaused

func SetLives(var livesLeft: int):
	for life in lifeBar.get_children():
		life.visible = false
	var lifeCounter = 0
	for life in lifeBar.get_children():
		life.visible = true
		lifeCounter = lifeCounter + 1
		print(lifeCounter)
		if(lifeCounter >= livesLeft):
			return


func _on_Player_lives_left(lives_left):
	SetLives(lives_left)
