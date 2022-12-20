extends CanvasLayer


func show_message(text):
	$Message.text = text
	$Message.show()

func _on_Player_died():
	show_message("YOU DIED")

func _on_Player_player_got_coin():
	show_message("YOU WON")
