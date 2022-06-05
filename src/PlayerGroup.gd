extends YSort


func _ready():
	var err = playerStats.connect("leveled_up", self, "on_player_level_up")
	assert(err == OK)

	playerStats.player = get_node("PlayerLevel1")
	playerStats.playerManager = self


func on_player_level_up(_previous_level):
	get_node("LevelUpSfx").play()
	if playerStats.level > 5:
		return
	
	var player = playerStats.player
	
	var new_player = load("res://scenes/PlayerLevel%d.tscn" % playerStats.level).instance()
	
	new_player.position = player.position
	call_deferred("add_child", new_player)
	playerStats.player = new_player
	player.queue_free()
	
