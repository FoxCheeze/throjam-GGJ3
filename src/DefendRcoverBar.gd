extends Control

export var bar_path: NodePath
export var defendProperties_path: NodePath

var bar
var defendProperties


func _ready():
	bar = get_node(bar_path) as TextureProgress
	defendProperties = get_node(defendProperties_path)

	bar.max_value = defendProperties.defend_recover_time


func _process(_delta):
	if playerStats.defendRecoverTimer.time_left <= 0:
		self.hide()
		return

	show()
	bar.value = playerStats.defendRecoverTimer.time_left
