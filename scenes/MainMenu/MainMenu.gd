extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var _err = $MusicInfo.start()
	if Checkpoint.current_level == "":
		$Play.text = "Play"
		$AudioStreamPlayer.play()
	else:
		$Play.text = "Continue"
		$AudioStreamPlayer.stop()

func _on_Shiryel_pressed():
	var _err = OS.shell_open("https://twitter.com/shiryel_")

func _on_RoxoFoxo_pressed():
	var _err = OS.shell_open("https://twitter.com/RoxoTheFoxo")

func _on_Play_pressed():
	if Checkpoint.current_level == "":
		var _err = get_tree().change_scene("res://scenes/Levels/Level1.tscn")
	else:
		var _err = get_tree().change_scene(Checkpoint.current_level)

func _on_source_pressed():
	var _err = OS.shell_open("https://github.com/shiryel/dungeon-dance-dance")
