extends Node2D

signal miss
signal hit

export var velocity = 2
export var music_json = ""
export (AudioStreamOGGVorbis) var audio_stream
export var velocity_offset = 0.3 # extra time before start
export var autoplay = false

var playing = false
var music = [] # will be loaded from json
var current_play_time # used by playing functions
var sprite_on = [] # what sprite is on the "bar"

func play():
	# set music notes and audio
	music = JSON.parse(music_json).result
	$AudioStreamPlayer2D.stream = audio_stream
	
	# start notes
	playing = true
	
	# start music
	current_play_time = -velocity
	get_tree().create_timer(velocity + velocity_offset).connect("timeout", self, "play_music")

func play_music():
	$AudioStreamPlayer2D.play(0)

func _ready():
	if autoplay:
		play()

func _process(delta):
	if playing:
		play_notes(delta)
		play_game()

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
			sprite.visible = true
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

func _on_right_body_entered(body):
	sprite_on.append({"note": "right", "body": body})

func _on_right_body_exited(_body):
	var result = find_by_note(sprite_on, "right")
	remove_if_any_exited_with_result(result)

func _on_left_body_entered(body):
	sprite_on.append({"note": "left", "body": body})

func _on_left_body_exited(_body):
	var result = find_by_note(sprite_on, "left")
	remove_if_any_exited_with_result(result)

func _on_up_body_entered(body):
	sprite_on.append({"note": "up", "body": body})

func _on_up_body_exited(_body):
	var result = find_by_note(sprite_on, "up")
	remove_if_any_exited_with_result(result)

func _on_down_body_entered(body):
	sprite_on.append({"note": "down", "body": body})

func _on_down_body_exited(_body):
	var result = find_by_note(sprite_on, "down")
	remove_if_any_exited_with_result(result)
		
func remove_if_any_exited_with_result(result):
	if result:
		sprite_on.remove(sprite_on.find(result))
		result.body.queue_free()
		emit_signal("miss")
	else:
		emit_signal("hit")