extends KinematicBody
class_name Player

export(NodePath) var cameraNodePath: NodePath

var health := 100

func damage(value: int) -> void:
	health -= value
	if health <= 0:
		GameManager.deathReason = "Life Advice: Try not to get shot too often..."
		GameManager.die()
