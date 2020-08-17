# This module is just to make notes for a music, it will create a JSON or load
# from JSON puting the results in the `music`

extends Node2D

var music = [] # music that is beging created
var recording = false # recording / playing
var miss = 0
var points = 0

func _process(delta):
	if recording:
		record()
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
	recording = true
	music = []
	$AudioStreamPlayer2D.play(0)

func _on_Copy_pressed():
	OS.clipboard = $JsonResult.text

func _on_Play_pressed():
	recording = false
	$AudioStreamPlayer2D.stop()
	$MusicPlayer.music_jsons = [$JsonResult.text]
	$MusicPlayer.play()

func _on_MusicPlayer_hit():
	points += 1

func _on_MusicPlayer_miss():
	miss += 1
