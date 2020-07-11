extends Enemy

signal arrested

var player

func _ready():
	for node in get_tree().get_nodes_in_group("player"):
		player = node
		connect("arrested", player, "_on_Arrested")

func _on_ArrestRange_body_entered(body):
	if body == player:
		$ArrestCountdown.start()

func _on_ArrestRange_body_exited(body):
	if body == player:
		$ArrestCountdown.stop()
	
func _on_ArrestCountdown_timeout():
	emit_signal("arrested")

