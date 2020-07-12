extends State

export(float, 0.1, 10.0) var SPEED_MULTIPLIER = 1.5

func on_enter(target: Player):
	$Timer.start()
	target.get_node("AnimatedSprite").frame = 4
	target.fear = 0

func on_physics_process(target: Player, delta: float):
	var enemies = get_tree().get_nodes_in_group("enemies")
	var direction = Vector2.ZERO
	for e in enemies:
		var distance = target.position - e.position
		direction += distance / distance.length_squared()
	target.move(direction.normalized() * target.SPEED * SPEED_MULTIPLIER)


func _on_Timer_timeout():
	go_to("PlayerController")
