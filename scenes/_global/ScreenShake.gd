extends Tween

var amplitude = 0
var frequency = 0
var priority = 0

onready var camera = get_parent()
onready var shaker_timer = Timer.new() # repeat forever

func _ready():
	add_child(shaker_timer)
	shaker_timer.connect("timeout", self, "_new_shake")

func shake(duration = 0.2, frequency = 15, amplitude = 16, priority = 0):
	# to be possible to "overwrite" the shake
	if priority >= self.priority:
		self.priority = priority
		self.amplitude = amplitude
		self.frequency = 1 / float(frequency)

		# configure the shaker timer
		shaker_timer.wait_time = self.frequency
		shaker_timer.start()

		# one short timer to end the screen shake
		get_tree().create_timer(duration).connect("timeout", self, "_reset_screen")

func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)

	print(TRANS_SINE)
	interpolate_property(camera, "offset", camera.offset, rand, frequency, TRANS_SINE, EASE_IN_OUT)
	start()

func _reset_screen():
	shaker_timer.stop()
	interpolate_property(camera, "offset", camera.offset, Vector2(), frequency, TRANS_SINE, EASE_IN_OUT)
	start()
