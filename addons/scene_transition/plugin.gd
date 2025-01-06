@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton("SceneTransition", "res://addons/scene_transition/script/SceneTransition.gd")


func _exit_tree() -> void:
	remove_autoload_singleton("SceneTransition")
