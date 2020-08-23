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
	
	tween.interpolate_property($WorldEnvironment.environment, "adjustment_contrast", 
		$WorldEnvironment.environment.adjustment_contrast, 2, 60,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	tween2.interpolate_property($WorldEnvironment.environment, "adjustment_saturation", 
		$WorldEnvironment.environment.adjustment_saturation, 0.01, 60,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween2.start()
	
	_err = yield(get_tree().create_timer(60), "timeout")
	tween.interpolate_property($WorldEnvironment.environment, "adjustment_contrast", 
		$WorldEnvironment.environment.adjustment_contrast, 0.9, 60,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	tween2.interpolate_property($WorldEnvironment.environment, "adjustment_saturation", 
		$WorldEnvironment.environment.adjustment_saturation, 1, 60,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween2.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialog.say("Welcome to your d... . . . *cof cof* stage 3", 5)
	yield(self, "next")
	$Dialog.say("Here I will test your... willpower.", 5)
	yield(self, "next")
	$Dialog.say("Let's start the mur... . fun? ", 5)
	yield(self, "next")
	
	if not skiped:
		$"../MusicPlayer".play()
		$"../MusicInfo".start()
		_world_changes()
	
	$Dialog.hide_skip_button()

func _on_MusicPlayer_finished():
	if not dead:
		$Dialog.show()
		$Dialog.say("Uh... eh... I wasn't expecting you to get so far...", 8)
		yield(self, "next")
		
		var _err = get_tree().change_scene("res://scenes/Levels/Level4.tscn")

func _on_Player_dead():
	if not dead:
		Checkpoint.deaths += 1
		dead = true
		$"../MusicPlayer".stop()
	
		$Dialog.show()
		$Dialog.say("AHAHAHAHA THAT'S ANOTHER ONE!", 4)
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
		var _err = get_tree().change_scene("res://scenes/Levels/Level3.tscn")

func _on_Dialog_skiped():
	skiped = true
	$"../MusicPlayer".play()
	$"../MusicInfo".start()
	_world_changes()

func _on_Dialog_done():
	yield(get_tree(), "idle_frame")
	emit_signal("next")
