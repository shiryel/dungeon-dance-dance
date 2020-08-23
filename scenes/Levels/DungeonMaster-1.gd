extends Node

var skiped = false
var dead = false

signal next

# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialog.say("Hello Adventurer...", 4)
	yield(self, "next")
	$Dialog.say("Welcome to my dungeon...", 5)
	yield(self, "next")
	$Dialog.say("You problably already know, but I need to follow the protocol... " + 
	"Here I'll test if you are worthy of taking the secrets of our " +
	"ancient civilization...", 16)
	yield(self, "next")
	$Dialog.say("So, let's start? Use W, A, S, D to get the points " +
	"you can use the right click to move around and " +
	"the left click to attack... and remember... make a minefield heheheheh", 16)
	yield(self, "next")
	
	if not skiped:
		$"../MusicPlayer".play()
		$"../MusicInfo".start()
	
	$Dialog.hide_skip_button()
	$Dialog.say("Good luck... you'll need it. Heheheh", 5)
	yield(self, "next")

func _on_MusicPlayer_finished():
	if not dead:
		$Dialog.show()
		$Dialog.say("Congratulations, you finished the tutorial!", 5)
		yield(self, "next")
		$Dialog.say("Ready for the next step? And remember, you can press ESC to pause the game", 7)
		yield(self, "next")
		$Dialog.say("Ok... let's go!", 3)
		yield(self, "next")
		
		var _err = get_tree().change_scene("res://scenes/Levels/Level2.tscn")

func _on_Player_dead():
	if not dead:
		Checkpoint.deaths += 1
		dead = true
		$"../MusicPlayer".stop()
	
		$Dialog.show()
		$Dialog.say("They came in a blink and they go in a blink... what a shame.", 6)
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
		var _err = get_tree().change_scene("res://scenes/Levels/Level1.tscn")

func _on_Dialog_skiped():
	skiped = true
	$"../MusicPlayer".play()
	$"../MusicInfo".start()

func _on_Dialog_done():
	yield(get_tree(), "idle_frame")
	emit_signal("next")
