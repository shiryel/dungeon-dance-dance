extends Node

var skiped = false
var dead = false

signal next


func _world_changes():
	var tween = Tween.new()
	add_child(tween)
	
	var tween2 = Tween.new()
	add_child(tween2)
	
	var _err = yield(get_tree().create_timer(30), "timeout")
	
	tween.interpolate_property($WorldEnvironment.environment, "adjustment_brightness", 
		$WorldEnvironment.environment.adjustment_brightness, 1.2, 60,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	tween2.interpolate_property($WorldEnvironment.environment, "adjustment_saturation", 
		$WorldEnvironment.environment.adjustment_saturation, 0.01, 60,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween2.start()
	
	_err = yield(get_tree().create_timer(60), "timeout")
	tween.interpolate_property($WorldEnvironment.environment, "adjustment_brightness", 
		$WorldEnvironment.environment.adjustment_brightness, 0.9, 60,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	tween2.interpolate_property($WorldEnvironment.environment, "adjustment_saturation", 
		$WorldEnvironment.environment.adjustment_saturation, 1, 60,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween2.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialog.say("you... . . .", 5)
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
		$Dialog.say("*after winning, you find a chest... It contains a piece of cake and the recipe*", 10)
		yield(self, "next")
		$Dialog.say("*gamedev 1: ... it is this?*", 7)
		yield(self, "next")
		$Dialog.say("*gamedev 2: ... we dont have much more time you know?*", 8)
		yield(self, "next")
		$Dialog.say("*gamedev 2: oh ok... *sad fennec noises* *", 8)
		yield(self, "next")
		$Dialog.say("*gamedev 1: Yes you can close the game now!*", 7)
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
			$Dialog.say("*Gamedev 1: hey, pssss, I was seeing you, and look that you are having a bad time...*", 10)
			yield(self, "next")
			$Dialog.say("*Gamedev 1: so here goes a hint: try to keep the right button pressed while spamming the left button of the mouse*", 14)
			yield(self, "next")
			$Dialog.say("*Gamedev 2: hey, that is a bug!*", 5)
			yield(self, "next")
			$Dialog.say("*Gamedev 1: nop, I promoved it to a feature :P*", 6)
			yield(self, "next")
			$Dialog.say("*Gamedev 2: you....*", 3)
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
