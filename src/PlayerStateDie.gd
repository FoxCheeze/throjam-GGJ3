extends State


func on_enter(_msg := {}):
	entity.collisionBoxes.disable_box(["All"])
	entity.set_deferred("collision_layer", 0)
	entity.animationPlayer.play("Die")
	yield(entity.animationPlayer, "animation_finished")


func physics_update(delta: float):
	entity.velocity = entity.velocity.move_toward(Vector2.ZERO, entity.friction * delta)

	entity.velocity = entity.move_and_slide(entity.velocity)
