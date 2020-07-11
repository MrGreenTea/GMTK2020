extends State

var stress = 0
const MAX_STRESS = 10.0
export var SPEED = 128.0


func on_enter(target: Player):
	target.get_node("AnimatedSprite").frame = 0


func on_physics_process(target: Player, delta: float) -> void:
	var x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	var y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	var direction = Vector2(x, y).normalized()
	var _a = target.move_and_slide(direction * SPEED)
	stress += delta
	var frame = round(float(stress) / MAX_STRESS * 2)
	print(frame)
	target.get_node("AnimatedSprite").frame = frame
	if stress >= MAX_STRESS:
		stress = 0
		print("I am stressed as fuck!!")
		go_to("Anger")
