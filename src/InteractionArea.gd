extends Area2D


func _ready():
	var err = connect("area_entered", self, "_on_InteractionArea_area_entered")
	assert(err == OK)


func _on_InteractionArea_area_entered(area: Area2D):
	playerStats.playerManager.get_node("Exp").play()
	if playerStats.level >= 5:
		playerStats.heal(area.experience_value)
		return
	
	playerStats.gain_experience(area.experience_value)
