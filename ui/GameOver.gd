extends ColorRect

onready var timerLabel = get_node("/root/Node2D/Overlay/Timer/TimerLabel").get_children()


func _on_Player_game_over(type):
	prints("Game over type:", type)
	
	var text = "You Lost"
	match type:
		"reached_target":
			text = "You were %s too late" % timerLabel.seconds_to_clock(timerLabel.time) #1000 #timer.$Label.time
		"arrested":
			text = "You were arrested."
		"car_crash":
			text = "You got run over by a car."
	$VBoxContainer/HowYouLost.text = text
