extends State

export(float, 0.1, 10.0) var SPEED_MULTIPLIER = 2.0

func on_enter(target: Player):
	$Timer.start()
	target.get_node("AnimatedSprite").frame = 4
	target.fear = 0
	var effect = randi() % 9
	var sound_effect = "res://sound/fear/aargh%d.ogg" % effect
	if effect == 8:
		sound_effect = "res://sound/fear/Wilhelm_Scream.ogg"
	$AudioStreamPlayer.stream = load(sound_effect)
	$AudioStreamPlayer.play()

func on_physics_process(target: Player, delta: float):
	var enemies = get_tree().get_nodes_in_group("enemies")
	var direction = Vector2.ZERO
	for e in enemies:
		var distance = target.position - e.position
		direction += distance / distance.length_squared()
	target.move(direction.normalized() * target.SPEED * SPEED_MULTIPLIER)


func _on_Timer_timeout():
	go_to("PlayerController")
