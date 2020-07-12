extends State

var stress = 0
export var MAX_STRESS = 10.0

const EMOTIONS = ["Anger", "Fear"]

func on_enter(target: Player):
	randomize()
	target.get_node("AnimatedSprite").frame = 0
	target.get_node("AnimatedSprite").hide()
	


func on_physics_process(target: Player, delta: float) -> void:
	var x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	var y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	var direction = Vector2(x, y).normalized()
	var player_frames: AnimatedSprite = target.get_node("PlayerFrame")
	if direction.length_squared() > 0.1:
		var movement = target.move(direction * target.SPEED)
		if movement.length() <= 0.1:
			target.add_anger(delta)
	else:
		player_frames.frame = 0
		player_frames.playing = false
	target.stress += delta
	var enemies = get_tree().get_nodes_in_group("enemies")
	# enemies in close vicinity cause fear
	for e in enemies:
		var dist = (e.position - target.position).length()
		if dist <= 192:
			var additional_fear = (100 / dist) * delta / sqrt(len(enemies)) * 0.25
			
			target.stress += delta
			if e.is_in_group("policemen"):
				additional_fear *= 5
			target.add_fear(additional_fear)

	# enemies touching us make us angry
	for e in target.get_node("PushArea").get_overlapping_bodies():
		target.add_anger(delta * 5)
	var stress_percentage = float(target.stress) / target.MAX_STRESS
	if stress_percentage > 0.85:
		var emote_sprite = target.get_node("AnimatedSprite")
		var frame = 0
		if stress_percentage > 0.95:
			frame = 2
		elif stress_percentage > 0.9:
			frame = 1
		emote_sprite.show()
		emote_sprite.frame = frame
		# target.get_node("EmotionPlayer").stop()
		target.get_node("EmotionPlayer").play("buildup")
	if target.stress >= target.MAX_STRESS:
		if target.anger > target.fear:
			go_to("Anger")
		elif target.fear > target.anger:
			go_to("Fear")
		else:
			on_enter(target)  # fake re entering for reset
			print("Nothing triggered me right now :)")
		target.stress = 0
