extends State

var chaseDetector: Area2D
var speed_multiplier: float = 1.1
var target: Entity = null


func _ready():
	yield(owner, "ready")
	chaseDetector = entity.collisionBoxes.get_node("ChaseDetector")

	var err = chaseDetector.connect("body_entered", self, "_onchaseDetector_body_entered")
	assert(err == OK)

	err = chaseDetector.connect("body_exited", self, "_onchaseDetector_body_exited")
	assert(err == OK)


func _onchaseDetector_body_entered(body):
	target = body
	if state_machine.state.name != "Attack" and state_machine.state.name != "Die": # Evita cancelar esses states
		state_machine.transition_state("Chase")


func on_enter(_msg := {}):
	chaseDetector.scale = Vector2(1.5, 1.5) # Aumenta o range do Chase para perseguir numa area mais extensa

	AnimationHandler.four_direction_animation(
		entity.animationPlayer,
		entity.looking_direction,
		entity.positionPivot,
		self.name
	)


func physics_update(delta):
	if target == null: # Muda de state se o player não existir (este aproach evita cancelar outros states)
		state_machine.transition_state("Idle")
		return

	var target_direction = (target.global_position - entity.global_position).normalized()
	entity.velocity = entity.velocity.move_toward((entity.max_speed * speed_multiplier) * target_direction, entity.acceleration * delta)

	entity.looking_direction = target_direction
	AnimationHandler.four_direction_animation(
		entity.animationPlayer,
		entity.looking_direction,
		entity.positionPivot,
		self.name
	)
	
	entity.velocity = entity.move_and_slide(entity.velocity)


func _onchaseDetector_body_exited(_body): # Torna o player inexistente para a AI
	target = null # OBS: Como sinais são assincronos usar somente eles pode causar cancelamentos de state


func on_exit():
	chaseDetector.scale = Vector2(1, 1) # Volta o Chase Range ao normal
