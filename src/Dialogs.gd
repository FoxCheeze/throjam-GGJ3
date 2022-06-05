extends CanvasLayer

func _ready():
	playerStats.connect("leveled_up", self, "on_level_up")
	get_node("Dialog1").show()


func on_level_up(_previous_level):
	if playerStats.level > 5:
		return
	
	get_node("Dialog%d" % playerStats.level).show()
