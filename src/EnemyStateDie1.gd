extends State

export var exp_drop: int = 2
export var drop_range: float = 100


func on_enter(_msg := {}):
	entity.collision_layer = 0
	entity.collisionBoxes.disable_box(["All"])
	entity.animationPlayer.play("Die")
	drop_exp(exp_drop)
	yield(entity.animationPlayer, "animation_finished")
	entity.queue_free()


func physics_update(delta: float):
	entity.velocity = entity.velocity.move_toward(Vector2.ZERO, entity.friction * delta)

	entity.velocity = entity.move_and_slide(entity.velocity)


func drop_exp(exp_amount: int):
	for _i in range(exp_amount):
		var new_position = Vector2(
			rand_range(entity.global_position.x - drop_range, entity.global_position.x + drop_range),
			rand_range(entity.global_position.y - drop_range, entity.global_position.y + drop_range)
		)

		var experience = preload("res://scenes/Experience.tscn").instance()
		experience.global_position = new_position
		get_tree().get_root().call_deferred("add_child", experience)

