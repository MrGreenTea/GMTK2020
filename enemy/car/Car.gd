extends KinematicBody2D


export var SPEED = 364
const COLORS = ["black", "blue", "green", "red", "yellow"]
const VARIATIONS = 5

func _ready():
	var color = COLORS[randi() % len(COLORS)]
	var variation = randi() % VARIATIONS + 1
	var image = load("res://enemy/car/car_%s_%d.png" % [color, variation])
	$Sprite.texture = image
	$AudioStreamPlayer2D.seek(rand_range(0, 1.0))
	

func _physics_process(delta):
	move_and_slide(self.transform.y * SPEED)


func _on_Area2D_body_entered(body):
	if body is Player:
		$AudioStreamPlayer2D.stream = preload("res://sound/tires.ogg")
		$AudioStreamPlayer2D.play()
		$AudioStreamPlayer2D.volume_db = 0
		body.show_game_over("car_crash")
