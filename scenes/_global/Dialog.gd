extends Control

signal done
signal skiped

var queue = []
export var skiped = false

func show():
	$Label.text = ""
	$Label.show()
	skiped = false

func say(string, time):
	if not skiped:
		_put(string)
		yield(get_tree().create_timer(time), "timeout")
		_reset()
		yield(get_tree().create_timer(2), "timeout")
	emit_signal("done")

func hide():
	$Button.hide()
	$Label.hide()

func hide_skip_button():
	$Button.hide()

func _put(string):
	for x in string:
		if not skiped:
			var _err = get_tree().create_timer(0.07).connect("timeout", self, "_add_char", [x])
			yield(get_tree().create_timer(0.07), "timeout")

func _add_char(c):
	$Label.text += c

func _reset():
	for _x in range(5):
		if not skiped:
			yield(get_tree().create_timer(0.1), "timeout")
			$Label.visible = false
			yield(get_tree().create_timer(0.1), "timeout")
			$Label.visible = true
	$Label.text = ""

func _on_Button_pressed():
	yield(get_tree(), "idle_frame")
	skiped = true
	$Label.text = ""
	$Label.hide()
	$Button.hide()
	emit_signal("skiped")
