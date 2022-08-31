extends KinematicBody2D

onready var animatedSprite = $AnimatedSprite
export (int) var speed = 200
var velocity = Vector2()

func get_keyboard_input():
	velocity = Vector2()
	# TODO: stop using UI inputs and create action inputs
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		animatedSprite.set_flip_h(false)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		animatedSprite.set_flip_h(true)
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	var input = Vector2()
	
	get_keyboard_input()
	velocity = move_and_slide(velocity)
	
	if velocity == Vector2(0,0):
		animatedSprite.set_animation("idle")
	else:
		animatedSprite.set_animation("run")
