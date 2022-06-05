extends Control

export var healthLabel_path: NodePath
export var healthBar_path: NodePath
export var entity_path: NodePath

var healthBar
var healthLabel
var entity


func _ready():
	healthBar = get_node(healthBar_path)
	healthLabel = get_node(healthLabel_path)
	entity = get_node(entity_path)


func _process(_delta):
	healthBar.max_value = entity.max_health
	healthBar.value = entity.health
	healthLabel.text = str(entity.health) + "/" + str(entity.max_health)
