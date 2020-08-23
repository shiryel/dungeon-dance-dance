extends Node

var skiped = false
var dead = false

signal next

# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialog.say("Welcome to your d... . . . *cof cof* stage 3", 5)
	yield(self, "next")
	$Dialog.say("Here I will test your willpower ", 5)
	yield(self, "next")
	$Dialog.say("Let start the mur... . fun? ", 5)
	yield(self, "next")
	
	if not skiped:
		$"../MusicPlayer".play()
		$"../MusicInfo".start()
	
	$Dialog.hide_skip_button()

func _on_MusicPlayer_finished():
	if not dead:
		$Dialog.show()
		$Dialog.say("Uh... eh... I was not expecting you to came to far...", 8)
		yield(self, "next")
		
		var _err = get_tree().change_scene("res://scenes/Levels/Level4.tscn")

func _on_Player_dead():
	if not dead:
		Checkpoint.deaths += 1
		dead = true
		$"../MusicPlayer".stop()
	
		$Dialog.show()
		$Dialog.say("AHAHAHAHA ONE MORE ONE MORE", 4)
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
		var _err = get_tree().change_scene("res://scenes/Levels/Level3.tscn")

func _on_Dialog_skiped():
	skiped = true
	$"../MusicPlayer".play()
	$"../MusicInfo".start()

func _on_Dialog_done():
	yield(get_tree(), "idle_frame")
	emit_signal("next")
