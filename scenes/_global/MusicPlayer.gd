extends Node2D

signal finished
signal miss
signal hit

export var velocity = 2
export var music_jsons = []
export (AudioStreamOGGVorbis) var audio_stream
export var velocity_offset = 0.3 # extra time before start
export var autoplay = false

var playing = false
var music = [] # will be loaded from json
var current_play_time # used by playing functions
var sprite_on = [] # what sprite is on the "bar"

func play():
	# set music notes and audio
	$AudioStreamPlayer.stream = audio_stream

	# start notes
	playing = true

	# start music
	current_play_time = -velocity
	var _err = get_tree().create_timer(velocity + velocity_offset).connect("timeout", self, "_play_music")

func stop():
	$AudioStreamPlayer.stop()
	playing = false

func _play_music():
	$AudioStreamPlayer.play(0)

func _ready():
	if autoplay:
		play()

func _process(delta):
	if playing:
		_load_music()
		_play_notes(delta)
		_play_game()

#########
# UTILS #
#########

func _find_by_note(list, note):
	for y in list:
		if y.note == note:
			return y
	return null

###########
# playing #
###########

func _load_music():
	if !music_jsons.empty() and music.empty():
		music = JSON.parse(music_jsons.pop_front()).result
	
# Play the current `music` var
func _play_notes(delta):
	# Because we cant get the current time before the music start...
	# we need to use the delta + a global variable...
	if $AudioStreamPlayer.playing:
		current_play_time = $AudioStreamPlayer.get_playback_position()
	else:
		current_play_time += delta
	
	# When spawning a note, it will use the velocity var
	# and the NoteEnd nodes to made the maths to set the node
	# velocity and get on the end in time to play the note in song
	if music.empty():
		return
	if music.front().time < current_play_time + velocity:
		_spawn_note(music.front().note)
		music.pop_front()

func _spawn_note(note):
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

func _play_game():
	for x in ["right", "left", "up", "down"]:
		var input = str("ui_", x)
		if Input.is_action_just_pressed(input):
			# press animation
			get_node(str("NoteEnd/SpritesEnd/", x, "/Sprite")).scale.x = 1.2
			get_node(str("NoteEnd/SpritesEnd/", x, "/Sprite")).scale.y = 1.2
			var _err = get_tree().create_timer(0.25).connect("timeout", self, str("_reset_sprite_end_", x))
			
			# verify if it hit the note
			var result = _find_by_note(sprite_on, x)
			if result != null:
				result.body.visible = false
				result.body.queue_free()
				sprite_on.remove(sprite_on.find(result))

func _reset_sprite_end_right():
	$NoteEnd/SpritesEnd/right/Sprite.scale.x = 1
	$NoteEnd/SpritesEnd/right/Sprite.scale.y = 1
	
func _reset_sprite_end_up():
	$NoteEnd/SpritesEnd/up/Sprite.scale.x = 1
	$NoteEnd/SpritesEnd/up/Sprite.scale.y = 1

func _reset_sprite_end_down():
	$NoteEnd/SpritesEnd/down/Sprite.scale.x = 1
	$NoteEnd/SpritesEnd/down/Sprite.scale.y = 1

func _reset_sprite_end_left():
	$NoteEnd/SpritesEnd/left/Sprite.scale.x = 1
	$NoteEnd/SpritesEnd/left/Sprite.scale.y = 1

################
# NOTE SIGNALS #
################

func _on_right_body_entered(body):
	sprite_on.append({"note": "right", "body": body})

func _on_right_body_exited(_body):
	var result = _find_by_note(sprite_on, "right")
	_remove_if_any_exited_with_result(result)

func _on_left_body_entered(body):
	sprite_on.append({"note": "left", "body": body})

func _on_left_body_exited(_body):
	var result = _find_by_note(sprite_on, "left")
	_remove_if_any_exited_with_result(result)

func _on_up_body_entered(body):
	sprite_on.append({"note": "up", "body": body})

func _on_up_body_exited(_body):
	var result = _find_by_note(sprite_on, "up")
	_remove_if_any_exited_with_result(result)

func _on_down_body_entered(body):
	sprite_on.append({"note": "down", "body": body})

func _on_down_body_exited(_body):
	var result = _find_by_note(sprite_on, "down")
	_remove_if_any_exited_with_result(result)

func _remove_if_any_exited_with_result(result):
	if result:
		# ease_out animation (keep in sync with the create_timer)
		var fadeout = Tween.new()
		add_child(fadeout)
		fadeout.interpolate_property(result.body, "scale", result.body.scale, Vector2(), 0.75, Tween.EASE_OUT)
		fadeout.start()
		
		# we need to remove from the sprite_on list now because of sync
		var _err = get_tree().create_timer(0.75).connect("timeout", self, "_remove", [result])
		sprite_on.remove(sprite_on.find(result))
		
		emit_signal("miss")
	else:
		emit_signal("hit")

func _remove(result):
	result.body.queue_free()

func _on_AudioStreamPlayer_finished():
	emit_signal("finished")
