extends Area2D

var damage: int
var knockback_force: float


func _ready():
	yield(owner, "ready")

	damage = owner.damage
	knockback_force = owner.knockback_force
