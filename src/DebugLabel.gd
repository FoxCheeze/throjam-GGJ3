extends Label


func _ready():
	pass


func _process(_delta):
	text = get_parent().get_node("StateMachine").state.name
