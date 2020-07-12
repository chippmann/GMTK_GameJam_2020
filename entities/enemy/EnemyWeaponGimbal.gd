extends Spatial
class_name EnemyWeaponGimbal

var player: Spatial

func _ready() -> void:
	if get_tree().get_nodes_in_group("player"):
		player = get_tree().get_nodes_in_group("player")[0]

func _process(delta: float) -> void:
	if player:
		look_at(player.transform.origin, Vector3.UP)
