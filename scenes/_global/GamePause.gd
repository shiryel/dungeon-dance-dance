extends Node

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _process(_delta):
	if Input.is_action_just_released("ui_pause"):
		get_tree().paused = !get_tree().paused
