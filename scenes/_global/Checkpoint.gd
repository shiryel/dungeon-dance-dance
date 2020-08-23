extends Node

export var deaths = 0
export var current_level = ""

func _process(_delta):
	if Input.is_action_just_released("ui_pause"):
		var _err = get_tree().change_scene("res://scenes/MainMenu/MainMenu.tscn")
