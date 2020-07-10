tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("CurveTween", "Tween", preload("res://addons/utils/curveTween/CurveTween.gd"), preload("res://addons/utils/curveTween/Curve.svg"))


func _exit_tree() -> void:
	remove_custom_type("CurveTween")
