@tool
extends EditorScript


func _run() -> void:
	var root := get_scene()

	if root == null:
		print("No scene is open.")
		return

	for item in root.get_children():
		if item is not Node3D:
			continue

		var mesh_instance := find_mesh_instance(item)

		if mesh_instance == null:
			print("Skipped, no MeshInstance3D found: ", item.name)
			continue

		if has_static_body(item):
			print("Skipped, already has collision: ", item.name)
			continue

		var static_body := StaticBody3D.new()
		static_body.name = "StaticBody3D"

		var collision_shape := CollisionShape3D.new()
		collision_shape.name = "CollisionShape3D"

		# Good for static GridMap / level pieces.
		collision_shape.shape = mesh_instance.mesh.create_trimesh_shape()

		static_body.add_child(collision_shape)
		item.add_child(static_body)

		# Important: owner must be set so Godot saves the new nodes into the scene.
		static_body.owner = root
		collision_shape.owner = root

		print("Added collision to: ", item.name)

	print("Finished adding collisions.")


func find_mesh_instance(node: Node) -> MeshInstance3D:
	if node is MeshInstance3D:
		return node

	for child in node.get_children():
		var found := find_mesh_instance(child)
		if found != null:
			return found

	return null


func has_static_body(node: Node) -> bool:
	for child in node.get_children():
		if child is StaticBody3D:
			return true

	return false
