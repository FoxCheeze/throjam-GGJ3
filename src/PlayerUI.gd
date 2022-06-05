extends Control

export var healthLabel_path: NodePath
export var healthBar_path: NodePath
export var expLabel_path: NodePath
export var expBar_path: NodePath
export var levelLabel_path: NodePath

var healthBar
var healthLabel
var expLabel
var expBar
var levelLabel


func _ready():
	healthBar = get_node(healthBar_path)
	healthLabel = get_node(healthLabel_path)
	expLabel = get_node(expLabel_path)
	expBar = get_node(expBar_path)
	levelLabel = get_node(levelLabel_path)


func _process(_delta):
	healthBar.max_value = playerStats.player.max_health
	healthBar.value = playerStats.player.health
	healthLabel.text = str(playerStats.player.health) + "/" + str(playerStats.player.max_health)

	expBar.max_value = playerStats.experience_required
	if playerStats.level < 5:
		expBar.value = playerStats.experience
		expLabel.text = str(playerStats.experience) + "/" + str(playerStats.experience_required)
	else:
		expLabel.text = "MAX"
		expBar.value = expBar.max_value

	levelLabel.text = str(playerStats.level)
