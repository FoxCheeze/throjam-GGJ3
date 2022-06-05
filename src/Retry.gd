extends Button


func _on_Retry_pressed():
	playerStats.restart()
	get_tree().reload_current_scene()
