extends Control

export var bar_path: NodePath
export var attackProperties_path: NodePath

var bar
var attackProperties


func _ready():
	bar = get_node(bar_path) as TextureProgress
	attackProperties = get_node(attackProperties_path)

	bar.max_value = attackProperties.attack_recover_time


func _process(_delta):
	if playerStats.attackRecoverTimer.time_left <= 0:
		self.hide()
		return

	show()
	bar.value = playerStats.attackRecoverTimer.time_left
