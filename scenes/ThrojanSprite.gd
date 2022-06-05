extends Sprite

signal player_won()

func _ready():
	var err = connect("player_won", playerStats, "on_player_victory")
	assert(err == OK)


func _process(_delta):
	self.modulate = Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1), rand_range(0, 1))
	if owner.health <= 0:
		emit_signal("player_won")
		set_process(false)
