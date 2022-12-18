extends Area2D

export (int) var speed = 200

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta

func destroy():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	destroy()


func _on_PlayerArrow_area_entered(_area):
	destroy()


func _on_PlayerArrow_body_entered(_body):
	destroy()
