extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.stop()

func transition_in():
	$AnimationPlayer.play("transition_out")


func transition_out():
	$AnimationPlayer.play_backwards("transition_out")
