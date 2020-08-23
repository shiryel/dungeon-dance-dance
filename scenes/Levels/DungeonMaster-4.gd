extends Node

var skiped = false
var dead = false

signal next


func _world_changes():
	var _err
	var brightness = Tween.new()
	add_child(brightness)
	
	_err = yield(get_tree().create_timer(2), "timeout")
	
	brightness.interpolate_property($WorldEnvironment.environment, "adjustment_brightness", 
		$WorldEnvironment.environment.adjustment_brightness, 1, 15,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	brightness.start()
	
	# 18.5
	_err = yield(get_tree().create_timer(16.5), "timeout")
	_error_contrast(1.5, 1, 0.5)
	
	# 18.5
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(2, 1, 0.5)
	
	# 22.5
	_err = yield(get_tree().create_timer(4), "timeout")
	_error_contrast(2, 1, 0.5)
	
	# 23.5
	_err = yield(get_tree().create_timer(1), "timeout")
	_error_saturation(1, 0.1, 2)
	
	# 25.5
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_saturation(0.1, 1, 1)
	
	# 27.5
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(3, 1, 0.5)
	
	# 33
	_err = yield(get_tree().create_timer(5.5), "timeout")
	_error_contrast(3, 1, 0.5)
	
	# 34
	_err = yield(get_tree().create_timer(1), "timeout")
	_error_contrast(3, 1, 0.5)
	
	# 38
	_err = yield(get_tree().create_timer(4), "timeout")
	_error_contrast(4, 1, 1)
	
	# 42
	_err = yield(get_tree().create_timer(4), "timeout")
	_error_contrast(6, 1, 0.5)
	
	# 43
	_err = yield(get_tree().create_timer(1), "timeout")
	_error_contrast(3, 1, 0.5)
	
	# 44
	_err = yield(get_tree().create_timer(1), "timeout")
	_error_contrast(3, 1, 0.5)
	
	# 45
	_err = yield(get_tree().create_timer(1), "timeout")
	_error_contrast(3, 1, 0.5)
	
	# 46
	_err = yield(get_tree().create_timer(1), "timeout")
	_error_contrast(4, 1, 0.5)
	
	# 48
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(6, 1, 0.5)
	
	# 50
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(4, 1, 0.5)
	
	# 52
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(6, 1, 0.5)
	
	#57
	_err = yield(get_tree().create_timer(5), "timeout")
	_error_saturation(1, 0.01, 3)
	
	# 100
	_err = yield(get_tree().create_timer(43), "timeout")
	_error_saturation(0.01, 1, 3)
	
	# 102
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(6, 1, 0.5)
	
	# 103
	_err = yield(get_tree().create_timer(1), "timeout")
	_error_contrast(6, 1, 0.5)
	
	# 135
	_err = yield(get_tree().create_timer(32), "timeout")
	_error_contrast(7, 1, 0.5)
	
	# 137
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(7, 1, 0.5)
	
	# 139
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(7, 1, 0.5)
	
	# 141
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(7, 1, 0.5)
	
	# 143
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(7, 1, 0.5)
	
	# 146
	_err = yield(get_tree().create_timer(3), "timeout")
	_error_contrast(8, 1, 0.5)
	
	# 148
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(6, 1, 0.5)
	
	# 150
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(6, 1, 0.5)
	
	#152
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(6, 1, 0.5)
	
	#156
	_err = yield(get_tree().create_timer(4), "timeout")
	_error_contrast(7, 1, 1)
	
	#158
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(7, 1, 0.5)
	
	#159
	_err = yield(get_tree().create_timer(1), "timeout")
	_error_contrast(7, 1, 0.5)
	
	#161
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(7, 1, 0.5)
	
	#163
	_err = yield(get_tree().create_timer(2), "timeout")
	_error_contrast(8, 1, 0.5)
	
	#164
	_err = yield(get_tree().create_timer(1), "timeout")
	_error_contrast(8, 1, 0.5)
	
	#165
	_err = yield(get_tree().create_timer(1), "timeout")
	_error_contrast(8, 1, 0.5)
	
	#166
	_err = yield(get_tree().create_timer(1), "timeout")
	_error_contrast(8, 1, 0.5)
	
	#169
	_err = yield(get_tree().create_timer(3), "timeout")
	_error_contrast(8, 1, 0.5)
	
	#170
	_err = yield(get_tree().create_timer(1), "timeout")
	_error_saturation(1, 0.01, 3)

func _error_brightness(start, end, time):
	var tween = Tween.new()
	add_child(tween)
	
	tween.interpolate_property($WorldEnvironment.environment, "adjustment_brightness", 
		$WorldEnvironment.environment.adjustment_brightness, start, time,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	var _err = yield(get_tree().create_timer(time), "timeout")
	
	tween.interpolate_property($WorldEnvironment.environment, "adjustment_brightness", 
		$WorldEnvironment.environment.adjustment_brightness, end, time,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func _error_contrast(start, end, time):
	var tween = Tween.new()
	add_child(tween)
	
	tween.interpolate_property($WorldEnvironment.environment, "adjustment_contrast", 
		$WorldEnvironment.environment.adjustment_contrast, start, time,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	var _err = yield(get_tree().create_timer(time), "timeout")
	
	tween.interpolate_property($WorldEnvironment.environment, "adjustment_contrast", 
		$WorldEnvironment.environment.adjustment_contrast, end, time,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func _error_saturation(start, end, time):
	var tween = Tween.new()
	add_child(tween)
	
	tween.interpolate_property($WorldEnvironment.environment, "adjustment_saturation", 
		$WorldEnvironment.environment.adjustment_saturation, start, time,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	var _err = yield(get_tree().create_timer(time), "timeout")
	
	tween.interpolate_property($WorldEnvironment.environment, "adjustment_saturation", 
		$WorldEnvironment.environment.adjustment_saturation, end, time,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialog.say("You... . . .", 5)
	yield(self, "next")
	$Dialog.say("DIE!", 5)
	yield(self, "next")
	
	if not skiped:
		$"../MusicPlayer".play()
		$"../MusicInfo".start()
		_world_changes()
	
	$Dialog.hide_skip_button()
	
	var _err = yield(get_tree().create_timer(58), "timeout")
	$Dialog.show()
	$Dialog.say("ERROR ERROR ERROR", 5)
	yield(self, "next")
	_err = yield(get_tree().create_timer(20), "timeout")
	$Dialog.say("RESTARTING RESTARTING...", 5)
	yield(self, "next")
	_err = yield(get_tree().create_timer(27), "timeout")
	$Dialog.say("AWWWWWWWWWWWWWWWWW... DIE!", 5)
	yield(self, "next")
	_err = yield(get_tree().create_timer(25), "timeout")
	$Dialog.say("CRITICAL ERROR", 5)
	yield(self, "next")
	$Dialog.say("INTERNAL FATAL ERROR", 5)
	yield(self, "next")
	$Dialog.say("123#$#%!#2$@%$%#$1AA#246123", 5)
	yield(self, "next")

func _on_MusicPlayer_finished():
	if not dead:
		$Dialog.show()
		$Dialog.say("*After the end of the song, you find a chest... It contains a piece of cake and a recipe.*", 10)
		yield(self, "next")
		$Dialog.say("*Gamedev 1: ... is this..?*", 7)
		yield(self, "next")
		$Dialog.say("*Gamedev 2: ... we dont have much more time you know?*", 8)
		yield(self, "next")
		$Dialog.say("*Gamedev 2: Oh ok... *Sad fennec noises* *", 8)
		yield(self, "next")
		$Dialog.say("*Gamedev 1: Yes you can close the game now!*", 7)
		yield(self, "next")
		
		var _err = get_tree().change_scene("res://scenes/MainMenu/MainMenu.tscn")

func _on_Player_dead():
	if not dead:
		Checkpoint.deaths += 1
		dead = true
		$"../MusicPlayer".stop()
	
		$Dialog.show()
		$Dialog.say("AHAHAHAHA FINALLY, I FINISHED MORE ONE, HAHAHAHHA", 5)
		yield(self, "next")
		
		# feature
		if Checkpoint.deaths > 5:
			$Dialog.say("*Gamedev 1: Hey, pssss, I was watching you, and I noticed that you are having a bad time...*", 10)
			yield(self, "next")
			$Dialog.say("*Gamedev 1: So here goes a hint: try to keep the right button pressed while spamming the left button of the mouse*", 14)
			yield(self, "next")
			$Dialog.say("*Gamedev 2: Hey, wait a second, that's a bug!*", 5)
			yield(self, "next")
			$Dialog.say("*Gamedev 1: Nope, I promoted it to a feature :P*", 6)
			yield(self, "next")
			$Dialog.say("*Gamedev 2: You...*", 3)
			yield(self, "next")
			Checkpoint.deaths = 0
		
		$Dialog.say("*System error: restarting...*", 3)
		yield(self, "next")
		var _err = get_tree().change_scene("res://scenes/Levels/Level4.tscn")

func _on_Dialog_skiped():
	skiped = true
	$"../MusicPlayer".play()
	$"../MusicInfo".start()
	_world_changes()

func _on_Dialog_done():
	yield(get_tree(), "idle_frame")
	emit_signal("next")
