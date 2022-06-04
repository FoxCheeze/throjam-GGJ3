extends State

export var attack_recover_time: float = 1.5


func _ready():
	yield(owner, "ready")

	var err = entity.animationPlayer.connect(
		"animation_finished",
		self,
		"_on_AnimationPlayer_animation_finished"
	)
	assert(err == OK, "failed to connect signal")


func on_enter(_msg: Dictionary = {}):
	entity.get_node("Slash").visible = true
	playerStats.can_attack = false
	playerStats.attackRecoverTimer.start(attack_recover_time)
	AnimationHandler.four_direction_animation(
		entity.animationPlayer,
		entity.looking_direction,
		entity.positionPivot,
		self.name
	)


func physics_update(delta: float):
	entity.velocity = entity.velocity.move_toward(
		Vector2.ZERO,
		entity.friction * delta
	)

	entity.velocity = entity.move_and_slide(entity.velocity)


func _on_AnimationPlayer_animation_finished(animation_name: String):
	if not animation_name.begins_with(self.name):
		return

	state_machine.transition_state("Idle")


func on_exit():
	entity.get_node("Slash").visible = false
	entity.collisionBoxes.disable_box(["HitBox"])

