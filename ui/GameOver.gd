extends ColorRect

var timerLabel

func _ready():
	for node in get_node("../Timer").get_children():
		if node.name == "TimerLabel":
			timerLabel = node
			break

func _on_Player_game_over(type):
	prints("Game over type:", type)
	match type:
		"reached_target":
			$VBoxContainer/HowYouLost.text = "You were %s too late" % timerLabel.seconds_to_clock(timerLabel.time) #1000 #timer.$Label.time
		"arrested":
			$VBoxContainer/HowYouLost.text = "You were arrested."
