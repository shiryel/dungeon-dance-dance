extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Shiryel_pressed():
	OS.shell_open("https://twitter.com/shiryel_")

func _on_RoxoFoxo_pressed():
	OS.shell_open("https://twitter.com/RoxoTheFoxo")

func _on_Play_pressed():
	get_tree().change_scene("res://scenes/Entrance.tscn")
