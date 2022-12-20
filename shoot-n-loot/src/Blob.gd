extends KinematicBody2D

signal hp_changed(hp)
signal died

onready var health_label = $HealthLabel

export (int) var max_hp = 20
export (int) var hp = max_hp setget set_hp

func set_hp(value):
	if value != hp:
		hp = clamp(value, 0, max_hp)
		emit_signal("hp_changed", hp)
		if hp == 0:
			emit_signal("died")

func _ready():
	health_label.set_text(str(self.hp))

func _physics_process(_delta):
	var player = get_parent().get_node_or_null("Player")
	if is_instance_valid(player):
		position += (player.position - position).normalized() * 0.7

func _on_Hurtbox_area_entered(hitbox: Area2D):
	if "damage" in hitbox:
		var damage = hitbox.damage
		self.hp -= damage
		health_label.set_text(str(self.hp))

	if hitbox.is_in_group("Projectile"):
		hitbox.destroy()

func _on_Blob_died():
	queue_free()
