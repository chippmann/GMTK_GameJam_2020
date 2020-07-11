extends KinematicBody
class_name Bullet

var color: Color

func _ready() -> void:
	var material := SpatialMaterial.new()
	material.emission_enabled = true
	material.albedo_color = Color.black
	material.emission_energy = 2
	material.emission = color
	
	$MeshInstance.material_override = material
	$MeshInstance/OmniLight.light_color = color


func _physics_process(delta: float) -> void:
	move_and_slide(-(transform.basis.z * 50), Vector3.UP)


func _on_Area_body_entered(body: Node) -> void:
	if body == self: return
	if body.is_in_group("player"):
		(body as Player).damage(25)
	
	if body.is_in_group("enemy"):
		(body as Enemy).damage(25)
	
	queue_free()
