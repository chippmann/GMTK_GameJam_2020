extends KinematicBody
class_name Player

export(NodePath) var cameraNodePath: NodePath
export(Material) var hurtMaterial: Material

var isHurt := false

var health := 100

var healthRegenInterval := 1
var time: float = 0
func _process(delta: float) -> void:
	time += delta
	if time >= healthRegenInterval:
		time -= healthRegenInterval
		health += 5
		if health > 100:
			health = 100


func damage(value: int, reason: String) -> void:
	if isHurt: return
	isHurt = true
	health -= value
	if health <= 0:
		GameManager.deathReason = reason
		GameManager.die()
		return
	$BodyMeshInstance.material_override = hurtMaterial
	yield(get_tree().create_timer(0.2), "timeout")
	$BodyMeshInstance.material_override = null
	yield(get_tree().create_timer(0.8), "timeout")
	isHurt = false
