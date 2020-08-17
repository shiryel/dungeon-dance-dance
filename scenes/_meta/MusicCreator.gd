# This module is just to make notes for a music, it will create a JSON or load
# from JSON puting the results in the `music`, the `velocity` is used by the
# playing `state`, to determine the velocity of notes, this is calculated from
# the function (distance between start and end / music time)

extends Node2D

export var velocity = 2
var music = [] # can be loaded from json
var state = "" # recording / playing
var current_play_time # used by playing functions

var sprite_on = []
var miss = 0
var points = 0

func _process(delta):
	if state == "recording":
		record()
	if state == "playing":
		play_notes(delta)
		play_game()
	$Score.text = str(points)
	$Miss.text = str(miss)

#########
# UTILS #
#########

func find_by_note(list, note):
	for y in list:
		if y.note == note:
			return y
	return null

###########
# playing #
###########

# Play the current `music` var
func play_notes(delta):
	# Because we cant get the current time before the music start...
	# we need to use the delta + a global variable...
	if $AudioStreamPlayer2D.playing:
		current_play_time = $AudioStreamPlayer2D.get_playback_position()
		$CurrentTime.text = str(current_play_time)
	else:
		current_play_time += delta
	
	# When spawning a note, it will use the velocity var
	# and the NoteEnd nodes to made the maths to set the node
	# velocity and get on the end in time to play the note in song
	if music.empty():
		return
	if music.front().time < current_play_time + velocity:
		spawn_note(music.front().note)
		music.pop_front()

func spawn_note(note):
	var sprite
	for x in ["right", "left", "up", "down"]:
		if note == x:
			sprite = get_node(str("Sprites/", x)).duplicate()
			add_child(sprite)
			var note_start = get_node(str("NoteStart/", x))
			sprite.position = note_start.position
			var distance = get_node(str("NoteEnd/", x)).position - note_start.position
			sprite.linear_velocity = distance / velocity

func play_game():
	for x in ["right", "left", "up", "down"]:
		var input = str("ui_", x)
		if Input.is_action_just_pressed(input):
			var result = find_by_note(sprite_on, x)
			if result != null:
				result.body.visible = false
				result.body.queue_free()
				sprite_on.remove(sprite_on.find(result))

func _on_Play_pressed():
	$AudioStreamPlayer2D.stop()
	state = "playing"
	current_play_time = -velocity
	get_tree().create_timer(velocity).connect("timeout", self, "play_music")

func play_music():
	$AudioStreamPlayer2D.play(0)

#############
# recording #
#############

# Record the keys pressed in the current time of the music and put it in the
# music variable to be used in the future tests, to make easy to export, it will
# be put in the JsonResult too
func record():
	var current_time = $AudioStreamPlayer2D.get_playback_position()
	$CurrentTime.text = str(current_time)
	
	for x in ["right", "left", "up", "down"]:
		var input = str("ui_", x)
		if Input.is_action_just_pressed(input):
			music.append({"time": current_time, "note": x})

	$JsonResult.text = JSON.print(music)

func _on_RecordNew_pressed():
	state = "recording"
	music = []
	$AudioStreamPlayer2D.play(0)

func _on_LoadCurrent_pressed():
	music = JSON.parse($JsonResult.text).result

func _on_right_body_entered(body):
	sprite_on.append({"note": "right", "body": body})

func _on_right_body_exited(body):
	var result = find_by_note(sprite_on, "right")
	sprite_on.remove(sprite_on.find(result))
	miss += 1

func _on_left_body_entered(body):
	sprite_on.append({"note": "left", "body": body})

func _on_left_body_exited(body):
	var result = find_by_note(sprite_on, "left")
	sprite_on.remove(sprite_on.find(result))
	miss += 1

func _on_up_body_entered(body):
	sprite_on.append({"note": "up", "body": body})

func _on_up_body_exited(body):
	var result = find_by_note(sprite_on, "up")
	sprite_on.remove(sprite_on.find(result))
	miss += 1

func _on_down_body_entered(body):
	sprite_on.append({"note": "down", "body": body})

func _on_down_body_exited(body):
	var result = find_by_note(sprite_on, "down")
	sprite_on.remove(sprite_on.find(result))
	miss += 1

func _on_Copy_pressed():
	OS.clipboard = $JsonResult.text
