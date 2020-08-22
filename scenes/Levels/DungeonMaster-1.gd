extends Node

var skiped = false
var dead = false

signal next

# Called when the node enters the scene tree for the first time.
func play():
	$Dialog.say("Hello Adventurer...", 4)
	yield(self, "next")
	$Dialog.say("Welcome to my dungeon...", 5)
	yield(self, "next")
	$Dialog.say("You problably already know, but I need to follow the protocol... " + 
	"Here I'll test if you are worthy of taking the secrets of our " +
	"ancient civilization...", 16)
	yield(self, "next")
	$Dialog.say("So, let's start? Use W, A, S, D to get the points " +
	"you can use the left click to move around and " +
	"the right click to attack... and remember... make a minefield heheheheh", 16)
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
		
		get_tree().change_scene("res://scenes/Levels/Level2.tscn")

func _on_Player_dead():
	if not dead:
		dead = true
		$"../MusicPlayer".stop()
	
		$Dialog.show()
		$Dialog.say("They came in a blink and they go in a blink... what a shame.", 5)
		yield(self, "next")

func _on_Dialog_skiped():
	$"../MusicPlayer".play()
	$"../MusicInfo".start()

func _on_Dialog_done():
	emit_signal("next")
