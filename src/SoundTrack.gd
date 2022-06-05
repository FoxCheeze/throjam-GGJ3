extends Node

export var defaut_db: float = 0


func _ready():
	set_process(false)
	for child in get_children():
		child.volume_db = -80
	
	var err = playerStats.connect("leveled_up", self, "on_Player_level_up")
	assert(err == OK)

	err = playerStats.connect("player_died", self, "on_Player_died")
	assert(err == OK)

	get_node("Layer1").volume_db = defaut_db


func _process(delta):
	for child in get_children():
		if not child.volume_db <= -80:
			child.volume_db -= 10 * delta


func on_Player_level_up(_previous_level):
	if playerStats.level >= 5:
		return
	
	get_node("Layer%d" % playerStats.level).volume_db = defaut_db


func on_Player_died():
	self.set_process(true)
