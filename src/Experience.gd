extends Area2D

export var experience_value = 10
export var magnetic_value = 300

var player: Entity = null


func _physics_process(delta: float):
	if playerStats.level >= 5:
		self.modulate = Color("#ff00cb")

	if player == null:
		return

	self.global_position = self.global_position.move_toward(player.global_position, magnetic_value * delta)


func _on_Experience_area_entered(_area):
	queue_free()


func _on_MagnetRange_body_entered(body):
	player = body


func _on_MagnetRange_body_exited(_body):
	player = null
