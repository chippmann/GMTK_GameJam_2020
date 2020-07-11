extends RigidBody
class_name FallingLight


func _ready() -> void:
	randomize()
	
	var color = Color(randf(), randf(), randf())
	var material := SpatialMaterial.new()
	material.emission_enabled = true
	material.albedo_color = Color.black
	material.emission_energy = 4
	material.emission = color
	
	$MeshInstance.material_override = material
	$MeshInstance/OmniLight.light_color = color
	
	apply_torque_impulse(Vector3(randi() % 5, randi() % 5, randi() % 5))


func _on_Area_body_entered(body: Node) -> void:
	if body == self: return
	if body.is_in_group("player"):
		GameManager.deathReason = "Try not to get hit by falling lamps..."
		GameManager.die()
	queue_free()
