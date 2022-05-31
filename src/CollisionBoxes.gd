class_name CollisionBoxes
extends Position2D
# disable_box e enable_box recebe um array de elementos para interagir.
# o array precisa ser de string contendo o nome dos nodes.
# você pode usar o argumento "All" para intaragir com todos e passar exeções caso precise.

func disable_box(to_disable: Array, exeption: Array = []) -> void:
	if to_disable.has("All"):
		for child in get_children():
			if not exeption.has(child.name):
				for grand_child in child.get_children():
					if grand_child is CollisionShape2D or grand_child is CollisionPolygon2D:
						grand_child.set_deferred("disabled", true)
	else:
		for element in to_disable:
			var child = get_node(element)
			for grand_child in child.get_children():
				if grand_child is CollisionShape2D or grand_child is CollisionPolygon2D:
					grand_child.set_deferred("disabled", true)


func enable_box(to_enable: Array, exeption: Array = []) -> void:
	if to_enable.has("All"):
		for child in get_children():
			if not exeption.has(child.name):
				for grand_child in child.get_children():
					if grand_child is CollisionShape2D or grand_child is CollisionPolygon2D:
						grand_child.set_deferred("disabled", false)
	else:
		for element in to_enable:
			var child = get_node(element)
			for grand_child in child.get_children():
				if grand_child is CollisionShape2D or grand_child is CollisionPolygon2D:
					grand_child.set_deferred("disabled", false)
