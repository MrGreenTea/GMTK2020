extends ColorRect

var player

func _ready():
	player = $AnimationPlayer
	player.stop()

func transition_in():
	player.play("transition_out")

func transition_out():
	player.play_backwards("transition_out")

