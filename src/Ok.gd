extends Button


func _on_Ok_pressed():
	get_parent().queue_free()
