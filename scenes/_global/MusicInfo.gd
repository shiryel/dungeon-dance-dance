extends Control

export var music_info = "asdsaddas"

func start():
	for x in "Music: " + music_info:
		var _err = get_tree().create_timer(0.15).connect("timeout", self, "_add_char", [x])
		yield(get_tree().create_timer(0.15), "timeout")
	yield(get_tree().create_timer(5), "timeout")

	for _x in music_info:
		var _err = get_tree().create_timer(0.1).connect("timeout", self, "_rm_char")
		yield(get_tree().create_timer(0.1), "timeout")

	for _x in range(6):
		yield(get_tree().create_timer(0.07), "timeout")
		$Label.visible = true
		yield(get_tree().create_timer(0.07), "timeout")
		$Label.visible = false

func _add_char(c):
	$Label.text += c

func _rm_char():
	$Label.text = "Music: " + $Label.text.substr(8)
