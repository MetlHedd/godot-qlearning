extends Node2D

func movePlayerBody(direction):
	if direction == "up":
		$KinematicBody2D.move_and_collide(Vector2(0, -32))
	elif direction == "down":
		$KinematicBody2D.move_and_collide(Vector2(0, 32))
	elif direction == "left":
		$KinematicBody2D.move_and_collide(Vector2(-32, 0))
	elif direction == "right":
		$KinematicBody2D.move_and_collide(Vector2(32, 0))

func _physics_process(delta):
	if Input.is_action_just_pressed("move_up"):
		movePlayerBody("up")
	elif Input.is_action_just_pressed("move_down"):
		movePlayerBody("down")
	elif Input.is_action_just_pressed("move_left"):
		movePlayerBody("left")
	elif Input.is_action_just_pressed("move_right"):
		movePlayerBody("right")
	
