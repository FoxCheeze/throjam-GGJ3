extends StaticBody2D


func _on_Area2D_body_entered(_body):
	if playerStats.level >= 5:
		get_node("Open").play()
		get_node("Collision").set_deferred("disabled", true)
		get_node("Area2D/CollisionShape2D").set_deferred("disabled", true)
