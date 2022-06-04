extends State

export var speed_multiplier: float = 2

var input_direction: Vector2 = Vector2.ZERO


func on_enter(_msg: Dictionary = {}):
	AnimationHandler.four_direction_animation(
		entity.animationPlayer,
		entity.looking_direction,
		entity.positionPivot,
		"Run"
	)
	entity.animationPlayer.playback_speed = speed_multiplier


func physics_update(delta: float):
	set_input_direction(
		Vector2(
			Input.get_axis("Left", "Right"),
			Input.get_axis("Up", "Down")
		).normalized()
	)

	entity.velocity = entity.velocity.move_toward(
		entity.max_speed * input_direction * speed_multiplier,
		entity.acceleration * delta * speed_multiplier
	)

	entity.velocity = entity.move_and_slide(entity.velocity)

	# Transitions
	if Input.is_action_just_released("Sprint") or input_direction == Vector2.ZERO:
		state_machine.transition_state("Idle")
	
	if Input.is_action_just_pressed("Doge"):
		state_machine.transition_state("Doge", {"direction": input_direction})
	
	if Input.is_action_just_pressed("Attack") and playerStats.can_attack:
		state_machine.transition_state("Attack")

	if Input.is_action_pressed("Defend") and playerStats.can_defend:
		state_machine.transition_state("Defend")


func set_input_direction(new_direction: Vector2):
	if new_direction == input_direction:
		return
	
	input_direction = new_direction
	entity.looking_direction = input_direction	
	AnimationHandler.four_direction_animation(
		entity.animationPlayer,
		entity.looking_direction,
		entity.positionPivot,
		"Run"
	)


func on_exit():
	entity.animationPlayer.playback_speed = 1
