extends KinematicBody2D

func _physics_process(_delta):
	var player = get_parent().get_node("Player")
	position += (player.position - position).normalized() * 0.7
