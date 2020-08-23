extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var _err = $MusicInfo.start()

func _on_Shiryel_pressed():
	var _err = OS.shell_open("https://twitter.com/shiryel_")

func _on_RoxoFoxo_pressed():
	var _err = OS.shell_open("https://twitter.com/RoxoTheFoxo")

func _on_Play_pressed():
	var _err = get_tree().change_scene("res://scenes/Levels/Level1.tscn")

func _on_source_pressed():
	var _err = OS.shell_open("https://github.com/shiryel/dungeon-dance-dance")
