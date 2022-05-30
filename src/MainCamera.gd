extends Camera2D

export var player_path: NodePath

var player: Entity = null


func _ready():
	player = get_node(player_path)


func _physics_process(_delta):
	self.global_position = player.global_position
