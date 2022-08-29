extends Sprite

func _physics_process(_delta):
	var input = Vector2()
	
	if Input.is_key_pressed(KEY_W) || Input.is_key_pressed(KEY_UP):
		input.y = -5
	if Input.is_key_pressed(KEY_S) || Input.is_key_pressed(KEY_DOWN):
		input.y = 5
	if Input.is_key_pressed(KEY_A) || Input.is_key_pressed(KEY_LEFT):
		input.x = -5
	if Input.is_key_pressed(KEY_D) || Input.is_key_pressed(KEY_RIGHT):
		input.x = 5
	
	position += input
