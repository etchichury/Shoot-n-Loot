extends Area2D

export (int) var speed = 100

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta

func destroy():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
