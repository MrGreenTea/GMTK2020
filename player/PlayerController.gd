extends State

var stress = 0
export var MAX_STRESS = 10.0

const EMOTIONS = ["Anger", "Fear"]

func on_enter(target: Player):
	target.get_node("AnimatedSprite").frame = 0


func on_physics_process(target: Player, delta: float) -> void:
	var x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	var y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	var direction = Vector2(x, y).normalized()
	if direction.length_squared() > 0.1:
		var movement = target.move_and_slide(direction * target.SPEED)
		if movement.length() <= 0.1:
			print("Can't move!")
			target.anger += delta
	target.stress += delta
	var frame = round(float(target.stress) / target.MAX_STRESS * 2)
	target.get_node("AnimatedSprite").frame = frame
	var enemies = get_tree().get_nodes_in_group("enemies")
	for e in enemies:
		var dist = (e.position - target.position).length()
		if dist <= 100:
			var additional_fear = (100 / dist) * delta / sqrt(len(enemies)) * 0.25
			target.stress += delta
			target.fear += additional_fear
			target.anger += additional_fear * 0.3
	if target.stress >= target.MAX_STRESS:
		if target.anger >= target.fear:
			go_to("Anger")
		elif target.fear > target.anger:
			go_to("Fear")
		target.stress = 0
