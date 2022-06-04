class_name StateMachine
extends Node

export (NodePath) var initial_state = null

var history: Array = []
var state: State = null
var states_names: Array = []

func _ready():
	yield(owner, "ready")

	set_self_on_children(self, self)

	assert(initial_state != null, "initial_state is `null`, please set a valid state.")
	state = get_node(initial_state) as State
	state.on_enter()


func set_self_on_children(node, stateMachine: StateMachine):
	if node.get_children() == []: 
		return
	
	for child in node.get_children():
		if child is State:
			states_names.append(child.name)
			child.state_machine = stateMachine as StateMachine

		set_self_on_children(child, stateMachine)


func _unhandled_input(event: InputEvent):
	state.handle_input(event)


func _process(delta: float):
	state.update(delta)


func _physics_process(delta: float):
	state.physics_update(delta)


func transition_state(target_state: String, msg: Dictionary = {}):
	if not target_state in states_names:
		return
	
	if state.name == "Die":
		return
	
	state.on_exit()

	history.push_front(state)
	if history.size() > 5:
		history.pop_back()

	state = get_node(target_state) as State
	assert(state is State, "`%s` is not a valid state." % state.name)

	state.on_enter(msg)
