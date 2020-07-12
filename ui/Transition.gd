extends ColorRect

var player

func _ready():
	player = $AnimationPlayer
	player.stop()

func transition_in():
	visible = true
	player.play("transition_out")

func transition_out():
	visible = true
	player.play_backwards("transition_out")

