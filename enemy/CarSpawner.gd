extends Area2D


export var CAR_ROTATION = 0
export var INITIAL_CARS = 28
export var CAR_SPEED = 364
const car = preload("res://enemy/car/Car.tscn")

func spawn_car():
	var car_instance = car.instance()
	car_instance.get_node("Sprite").rotation_degrees = CAR_ROTATION
	car_instance.rotation = self.rotation
	car_instance.SPEED = CAR_SPEED
	add_child(car_instance)
	return car_instance

func _ready():
	print(transform.y)
	var wait_time = $Timer.wait_time
	for i in range(INITIAL_CARS):
		var car_instance = spawn_car()
		var pos = Vector2.DOWN * wait_time * car_instance.SPEED * i
		car_instance.position = pos


func _on_Timer_timeout():
	if not self.get_overlapping_bodies():
		spawn_car()
