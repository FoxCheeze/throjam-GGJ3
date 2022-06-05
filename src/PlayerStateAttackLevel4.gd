extends State

export var distance: float = 80
export var attack_recover_time: float = 1.5

var animation_length: float
var direction: Vector2 = Vector2.ZERO


func _ready():
	yield(owner, "ready")

	var err = entity.animationPlayer.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	assert(err == OK, "failed to connect signal")


func on_enter(_msg: Dictionary = {}):
	entity.sfx.get_node("Hit").play()
	entity.get_node("Slash").visible = true
	direction = entity.looking_direction
	AnimationHandler.four_direction_animation(
		entity.animationPlayer,
		entity.looking_direction,
		entity.positionPivot,
		self.name
	)

	animation_length = entity.animationPlayer.current_animation_length



func physics_update(_delta: float):
	entity.velocity = direction * (distance / animation_length)

	entity.velocity = entity.move_and_slide(entity.velocity)


func _on_AnimationPlayer_animation_finished(animation_name: String):
	if not animation_name.begins_with(self.name):
		return
	
	state_machine.transition_state("Idle")


func on_exit():
	entity.get_node("Slash").visible = false
	entity.collisionBoxes.disable_box(["HitBox"])
	playerStats.can_attack = false
	playerStats.attackRecoverTimer.start(attack_recover_time)
