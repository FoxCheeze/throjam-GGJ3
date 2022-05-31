extends Area2D


func _ready():
	var err = connect("area_entered", self, "_on_HurtBox_area_entered")
	assert(err == OK)


func _on_HurtBox_area_entered(area):
	owner.recieve_damage(area.damage)
	owner.recieve_knockback(area.knockback_force, (area.global_position - owner.global_position).normalized() * -1)
