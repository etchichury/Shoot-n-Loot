extends KinematicBody2D

onready var health_label = $HealthLabel

export (int) var hp = 20

func _ready():
	health_label.set_text(str(self.hp))

func _physics_process(_delta):
	var player = get_parent().get_node("Player")
	position += (player.position - position).normalized() * 0.7

func _on_Hurtbox_area_entered(hitbox: Area2D):
	print(hitbox.get_parent().name)
	if "damage" in hitbox:
		var damage = hitbox.damage
		self.hp -= damage
		health_label.set_text(str(self.hp))
		print(hitbox.get_parent().name + "'s hitbox touched " + name + "'s hitbox and dealt " + str(damage))
	
	if hitbox.is_in_group("Projectile"):
		hitbox.destroy()
