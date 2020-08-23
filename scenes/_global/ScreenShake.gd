extends Tween

var _amplitude = 0
var _frequency = 0
var _priority = 0

onready var camera = get_parent()
onready var shaker_timer = Timer.new() # repeat forever

func _ready():
	add_child(shaker_timer)
	shaker_timer.connect("timeout", self, "_new_shake")

func shake(duration = 0.2, frequency = 15, amplitude = 16, priority = 0):
	# to be possible to "overwrite" the shake
	if priority >= _priority:
		_priority = priority
		_amplitude = amplitude
		_frequency = 1 / float(frequency)

		# configure the shaker timer
		shaker_timer.wait_time = _frequency
		shaker_timer.start()

		# one short timer to end the screen shake
		var _err = get_tree().create_timer(duration).connect("timeout", self, "_reset_screen")

func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-_amplitude, _amplitude)
	rand.y = rand_range(-_amplitude, _amplitude)

	var _err = interpolate_property(camera, "offset", camera.offset, rand, _frequency, TRANS_SINE, EASE_IN_OUT)
	return start()

func _reset_screen():
	shaker_timer.stop()
	var _err = interpolate_property(camera, "offset", camera.offset, Vector2(), _frequency, TRANS_SINE, EASE_IN_OUT)
	return start()
