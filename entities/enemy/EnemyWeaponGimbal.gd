extends Spatial
class_name EnemyWeaponGimbal

onready var player: Spatial = get_tree().get_nodes_in_group("player")[0]

func _process(delta: float) -> void:
	look_at(player.transform.origin, Vector3.UP)
