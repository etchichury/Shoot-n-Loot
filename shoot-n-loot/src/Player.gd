extends KinematicBody2D

signal hp_changed(hp)
signal player_got_coin
signal died

onready var animatedSprite = $AnimatedSprite
onready var atack_timer = $AttackTimer
onready var health_label = $HealthLabel

export (int) var max_hp = 50
export (int) var hp = max_hp setget set_hp
export (int) var speed = 200
export var arrow = preload("res://src/projectiles/PlayerArrow.tscn")

var velocity = Vector2()

func set_hp(value):
	if value != hp:
		hp = clamp(value, 0, max_hp)
		emit_signal("hp_changed", hp)
		if hp == 0:
			emit_signal("died")

func _ready():
	health_label.set_text(str(self.hp))

func get_keyboard_input():
	velocity = Vector2()
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
		var arrow_direction = self.global_position.direction_to(get_global_mouse_position())
		shoot_arrow(arrow_direction)
		atack_timer.start()

func shoot_arrow(arrow_direction: Vector2):
	if Input.is_action_pressed("action_fire") && atack_timer.is_stopped():
		var arrow_instance = arrow.instance()
		get_tree().current_scene.add_child(arrow_instance)
		arrow_instance.global_position = self.global_position
		
		var arrow_angle = arrow_direction.angle()
		arrow_instance.rotation = arrow_angle

func _physics_process(_delta):
	get_mouse_input()
	
	get_keyboard_input()
	velocity = move_and_slide(velocity)

	if velocity == Vector2(0,0):
		animatedSprite.set_animation("idle")
	else:
		animatedSprite.set_animation("run")


func _on_Hurtbox_area_entered(hitbox):
	if "damage" in hitbox:
		var damage = hitbox.damage
		self.hp -= damage
		health_label.set_text(str(self.hp))

func _on_Player_died():
	queue_free()
	
func _on_Player_got_coin():
	emit_signal("player_got_coin")
