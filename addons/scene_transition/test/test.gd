extends Control


func _ready() -> void:
	await get_tree().create_timer(1).timeout
	
	get_tree().paused = true
	
	await SceneTransition.random_in(1.0)
	await SceneTransition.random_out(1.0)
	
	get_tree().paused = false
