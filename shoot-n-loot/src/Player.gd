extends KinematicBody2D

onready var animatedSprite = $AnimatedSprite
onready var atack_timer = $AttackTimer

export (int) var speed = 200
export var dagger = preload("res://src/projectiles/PlayerArrow.tscn")

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

func get_mouse_input():
	if Input.is_action_pressed("action_fire"):
		var dagger_direction = self.global_position.direction_to(get_global_mouse_position())
		throw_dagger(dagger_direction)
		atack_timer.start()

# TODO: change 'dagger' term to 'arrow'
func throw_dagger(dagger_direction: Vector2):
	if Input.is_action_pressed("action_fire") && atack_timer.is_stopped():
		var dagger_instance = dagger.instance()
		get_tree().current_scene.add_child(dagger_instance)
		dagger_instance.global_position = self.global_position
		
		var dagger_angle = dagger_direction.angle()
		dagger_instance.rotation = dagger_angle

func _physics_process(_delta):
	get_mouse_input()
	
	get_keyboard_input()
	velocity = move_and_slide(velocity)

	if velocity == Vector2(0,0):
		animatedSprite.set_animation("idle")
	else:
		animatedSprite.set_animation("run")
