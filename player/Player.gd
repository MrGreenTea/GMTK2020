extends KinematicBody2D
class_name Player

export var SPEED = 192.0
var stress = 0
export var MAX_STRESS = 10.0
var anger = 0
var fear = 0

const PARTICLE_SPEED = 1000.0

var _anger_to_add = 0.0
var _fear_to_add = 0.0

onready var frames = $PlayerFrame
var game_is_over = false

signal game_over(type)

func _on_Target_body_entered(body):
	if body == self:
		show_game_over("reached_target")


func _physics_process(delta):
	anger += _anger_to_add
	adjust_particles($AngerParticles, _anger_to_add, $AngerTimer)
	_anger_to_add = 0
	
	fear += _fear_to_add
	adjust_particles($FearParticles, _fear_to_add, $FearTimer)
	_fear_to_add = 0


func adjust_particles(node: Particles2D, amount: float, timer: Timer):
	if amount > 0:
		node.process_material.scale = max(clamp(amount, 0.0, 1.0) * 100.0, 2.0)
		node.show()
		timer.start()

func add_anger(amount: float):
	_anger_to_add += amount
	stress += amount

func add_fear(amount: float):
	_fear_to_add += amount
	stress += amount
	
func _on_Arrested():
	show_game_over("arrested")

func move(direction: Vector2):
	if not $Footsteps.playing:
		var foot_step = "res://player/footstep_wood_00%d.ogg" % (randi() % 5)
		var sound = load(foot_step)
		$Footsteps.stream = sound
		$Footsteps.play()
		
	if abs(direction.x) > abs(direction.y):
		if direction.x < 0:
			frames.animation = "LEFT"
		else:
			frames.animation = "RIGHT"
	else:
		if direction.y > 0:
			frames.animation = "DOWN"
		else:
			frames.animation = "UP"
	frames.playing = true
	return move_and_slide(direction)

func show_game_over(type):
	if not game_is_over:
		game_is_over = true
		emit_signal("game_over", type)
		get_node("/root/Node2D/Overlay/Transition").transition_out()
		yield(get_node("/root/Node2D/Overlay/Transition/AnimationPlayer"),"animation_finished") 
		get_node("/root/Node2D/Overlay/GameOver").visible = true
		yield(get_tree().create_timer(5), "timeout")
		get_tree().reload_current_scene()


func _on_FearTimer_timeout():
	$FearParticles.hide()


func _on_AngerTimer_timeout():
	$AngerParticles.hide()
