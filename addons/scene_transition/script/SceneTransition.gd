extends Node

const SCENE = preload("res://addons/scene_transition/scene/scene.tscn")
const CIRCLE_SHADER = preload("res://addons/scene_transition/shaders/circle.gdshader")
const DIAMOND_SHADER = preload("res://addons/scene_transition/shaders/diamond.gdshader")
const PIXEL_SHADER = preload("res://addons/scene_transition/shaders/pixel.gdshader")
const LINIE_SHADER = preload("res://addons/scene_transition/shaders/linie.gdshader")
const BAR_SHADER = preload("res://addons/scene_transition/shaders/bar.gdshader")
const RADIAL_SHADER = preload("res://addons/scene_transition/shaders/radial.gdshader")
const DISOLVE_SHADER = preload("res://addons/scene_transition/shaders/disolve.gdshader")
const SWEEPING_DIAMOND = preload("res://addons/scene_transition/shaders/sweeping_diamond.gdshader")

const SCRIBBLES_IMAGE = preload("res://addons/scene_transition/shaders/images/scribbles.png")
const HORIZ_PAINT_BRUSH = preload("res://addons/scene_transition/shaders/images/horiz_paint_brush.png")

enum Directions {RIGHT, UP, LEFT, DOWN}

var backgroundColor := Color(0,0,0)

func fade_in(duration := 0.5):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.modulate.a = 0
	
	await _do_tween(transitionScene, "modulate:a", 1, duration)
	
	transitionScene.queue_free()
	
func fade_out(duration := 0.5):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.modulate.a = 1
	
	await _do_tween(transitionScene, "modulate:a", 0, duration)
	
	transitionScene.queue_free()

func wipe_in(duration := 0.5, direction: Directions = Directions.RIGHT):
	var transitionScene = _add_transition_scene()
	var screenSize = Vector2(get_viewport().size)
	var startPosition = _transform_direction(direction) * screenSize
	
	transitionScene.color_rect.global_position -= startPosition

	await _do_tween(transitionScene.color_rect, "global_position", Vector2.ZERO, duration)

	transitionScene.queue_free()
	
func wipe_out(duration := 0.5, direction: Directions = Directions.RIGHT):
	var transitionScene = _add_transition_scene()
	var screenSize = Vector2(get_viewport().size)
	var targetPosition = _transform_direction(direction) * screenSize
	
	transitionScene.color_rect.global_position = Vector2.ZERO
	
	await _do_tween(transitionScene.color_rect, "global_position", targetPosition, duration)
	
	transitionScene.queue_free()
	
func circle_in(duration := 1.0):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = CIRCLE_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("circle_size", 1.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/circle_size", 0.0, duration)
	
	transitionScene.queue_free()
	
func circle_out(duration := 1.0):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = CIRCLE_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("circle_size", 0.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/circle_size", 1.0, duration)

	transitionScene.queue_free()

func diamond_in(duration := 1.0, diamondSize := 25.0):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = DIAMOND_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("diamondPixelSize", diamondSize)
	transitionScene.color_rect.material.set_shader_parameter("progress", 0.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/progress", 1.0, duration)
	
	transitionScene.queue_free()
	
func diamond_out(duration := 1.0, diamondSize := 25.0):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = DIAMOND_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("diamondPixelSize", diamondSize)
	transitionScene.color_rect.material.set_shader_parameter("progress", 1.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/progress", 0.0, duration)

	transitionScene.queue_free()

func pixel_in(duration := 1.0):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = PIXEL_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("time", 1.6)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/time", 0.0, duration)
	
	transitionScene.queue_free()
	
func pixel_out(duration := 1.0):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = PIXEL_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("time", 0.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/time", 1.6, duration)
	
	transitionScene.queue_free()

func linie_in(duration := 1.0, on_y_axis := true):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = LINIE_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("on_y_axis", on_y_axis)
	transitionScene.color_rect.material.set_shader_parameter("threshold", 0.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/threshold", 1.0, duration)
	
	transitionScene.queue_free()
	
func linie_out(duration := 1.0, on_y_axis := true):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = LINIE_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("on_y_axis", on_y_axis)
	transitionScene.color_rect.material.set_shader_parameter("threshold", 1.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/threshold", 0.0, duration)
	
	transitionScene.queue_free()

func bar_in(duration := 1.0, on_y_axis := true):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = BAR_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("on_y_axis", on_y_axis)
	transitionScene.color_rect.material.set_shader_parameter("threshold", 0.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/threshold", 1.0, duration)
	
	transitionScene.queue_free()
	
func bar_out(duration := 1.0, on_y_axis := true):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = BAR_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("on_y_axis", on_y_axis)
	transitionScene.color_rect.material.set_shader_parameter("threshold", 1.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/threshold", 0.0, duration)
	
	transitionScene.queue_free()

func radial_in(duration := 1.0):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = RADIAL_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("cooldown_progress", 1.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/cooldown_progress", 0.0, duration)
	
	transitionScene.queue_free()
	
func radial_out(duration := 1.0):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = RADIAL_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("cooldown_progress", 0.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/cooldown_progress", 1.0, duration)
	
	transitionScene.queue_free()

func scribbles_in(duration := 1.0):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = DISOLVE_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("dissolve_texture", SCRIBBLES_IMAGE)
	transitionScene.color_rect.material.set_shader_parameter("amount", 0.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/amount", 1.0, duration)
	
	transitionScene.queue_free()

func scribbles_out(duration := 1.0):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = DISOLVE_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("dissolve_texture", SCRIBBLES_IMAGE)
	transitionScene.color_rect.material.set_shader_parameter("amount", 1.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/amount", 0.0, duration)
	
	transitionScene.queue_free()

func paint_brush_in(duration := 1.0):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = DISOLVE_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("dissolve_texture", HORIZ_PAINT_BRUSH)
	transitionScene.color_rect.material.set_shader_parameter("amount", 0.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/amount", 1.0, duration)
	
	transitionScene.queue_free()

func paint_brush_out(duration := 1.0):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = DISOLVE_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("dissolve_texture", HORIZ_PAINT_BRUSH)
	transitionScene.color_rect.material.set_shader_parameter("amount", 1.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/amount", 0.0, duration)
	
	transitionScene.queue_free()

func sweeping_diamond_in(duration := 1.0, diamondSize := 35.0):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = SWEEPING_DIAMOND
	
	transitionScene.color_rect.material.set_shader_parameter("diamondPixelSize", diamondSize)
	transitionScene.color_rect.material.set_shader_parameter("progress", 0.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/progress", 1.0, duration)
	
	transitionScene.queue_free()
	
func sweeping_diamond_out(duration := 1.0, diamondSize := 35.0):
	var transitionScene = _add_transition_scene()
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = SWEEPING_DIAMOND
	
	transitionScene.color_rect.material.set_shader_parameter("diamondPixelSize", diamondSize)
	transitionScene.color_rect.material.set_shader_parameter("progress", 1.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/progress", 0.0, duration)

	transitionScene.queue_free()

func random_in(duration := 1.0):
	var transitionList = [
		fade_in, wipe_in, circle_in, diamond_in, pixel_in, linie_in, bar_in, 
		radial_in, scribbles_in, paint_brush_in, sweeping_diamond_in
	]
	
	await transitionList.pick_random().call(duration)

func random_out(duration := 1.0):
	var transitionList = [
		fade_out, wipe_out, circle_out, diamond_out, pixel_out, linie_out, bar_out, 
		radial_out, scribbles_out, paint_brush_out, sweeping_diamond_out
	]
	
	await transitionList.pick_random().call(duration)

func change_color(newColor: Color):
	backgroundColor = newColor

func _add_transition_scene():
	var scene = SCENE.instantiate()
	get_tree().root.add_child(scene)
	
	scene.color_rect.color = backgroundColor
	
	return scene

func _transform_direction(direction: Directions):
	match direction:
		Directions.RIGHT: return Vector2.RIGHT
		Directions.UP: return Vector2.UP
		Directions.LEFT: return Vector2.LEFT
		Directions.DOWN: return Vector2.DOWN

func _do_tween(object: Object, property: NodePath, final_val: Variant, duration: float):
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(object, property, final_val, duration)
	await tween.finished
