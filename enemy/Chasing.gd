extends State

func on_physics_process(target: Enemy, delta: float) -> void:
	var target_node = target
	if target_node.follow_target != null && target_node.is_aggressive:
		var run_to = target_node.follow_target - target_node.position
		if run_to.length() > target_node.follow_tolerance:
			var direction = (target_node.follow_target - target_node.position).normalized()
			target_node.move(target_node.SPEED * direction)
		else:
			go_to("Idle")

