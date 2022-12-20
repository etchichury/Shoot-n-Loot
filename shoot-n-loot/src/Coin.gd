extends Area2D

signal got_coin

func _ready():
	$AnimationPlayer.play("bounce")

func _on_Coin_body_entered(_body):
	emit_signal("got_coin")
	print("Emiting got coin")
	queue_free()
