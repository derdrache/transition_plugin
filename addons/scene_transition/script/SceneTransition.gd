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
enum Transition_Type {IN, OUT}

var backgroundColor := Color(0,0,0)

func fade_in(duration := 0.5):
	await _transition_fade(Transition_Type.IN, duration)
	
func fade_out(duration := 0.5):
	await _transition_fade(Transition_Type.OUT, duration)

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
	await _transition_circle(Transition_Type.IN, duration)
	
func circle_out(duration := 1.0):
	await _transition_circle(Transition_Type.OUT, duration)

func diamond_in(duration := 1.0, diamondSize := 25.0):
	await _transition_diamond(Transition_Type.IN, duration, diamondSize)
	
func diamond_out(duration := 1.0, diamondSize := 25.0):
	await _transition_diamond(Transition_Type.IN, duration, diamondSize)

func pixel_in(duration := 1.0):
	await _transition_pixel(Transition_Type.IN, duration)
	
func pixel_out(duration := 1.0):
	await _transition_pixel(Transition_Type.OUT, duration)

func linies_in(duration := 1.0, on_y_axis := true):
	await _transition_lines(Transition_Type.IN, duration, on_y_axis)
	
func linies_out(duration := 1.0, on_y_axis := true):
	await _transition_lines(Transition_Type.OUT, duration, on_y_axis)

func bar_in(duration := 1.0, on_y_axis := true):
	await _transition_bar(Transition_Type.IN, duration, on_y_axis)
	
func bar_out(duration := 1.0, on_y_axis := true):
	await _transition_bar(Transition_Type.OUT, duration, on_y_axis)

func radial_in(duration := 1.0):
	await _transition_radial(Transition_Type.IN, duration)
	
func radial_out(duration := 1.0):
	await _transition_radial(Transition_Type.OUT, duration)

func scribbles_in(duration := 1.0):
	await _transition_scribbles(Transition_Type.IN, duration)

func scribbles_out(duration := 1.0):
	await _transition_scribbles(Transition_Type.OUT, duration)

func paint_brush_in(duration := 1.0):
	await _transition_paint_brush(Transition_Type.IN, duration)

func paint_brush_out(duration := 1.0):
	await _transition_paint_brush(Transition_Type.OUT, duration)

func sweeping_diamond_in(duration := 1.0, diamondSize := 35.0):
	await _transition_sweeping_diamond(Transition_Type.IN, duration, diamondSize)
	
func sweeping_diamond_out(duration := 1.0, diamondSize := 35.0):
	await _transition_sweeping_diamond(Transition_Type.OUT, duration, diamondSize)

func random_in(duration := 1.0):
	var transitionList = [
		fade_in, wipe_in, circle_in, diamond_in, pixel_in, linies_in, bar_in, 
		radial_in, scribbles_in, paint_brush_in, sweeping_diamond_in
	]
	
	var selectedTransition = transitionList.pick_random()
	await selectedTransition.call(duration)
	
	return transitionList.find(selectedTransition)

func random_out(duration := 1.0, selectedRandomTransition := -1):
	var transitionList = [
		fade_out, wipe_out, circle_out, diamond_out, pixel_out, linies_out, bar_out, 
		radial_out, scribbles_out, paint_brush_out, sweeping_diamond_out
	]
	
	if selectedRandomTransition != -1:
		await transitionList[selectedRandomTransition].call(duration)
		return 
	
	await transitionList.pick_random().call(duration)

func change_color(newColor: Color):
	backgroundColor = newColor


func _transition_fade(transitionType: Transition_Type, duration: float):
	var transitionScene = _add_transition_scene()
	var startValue = 0.0 if transitionType == Transition_Type.IN else 1.0
	var endValue = 1.0 if transitionType == Transition_Type.IN else 0.0
	
	transitionScene.color_rect.modulate.a = startValue
	
	await _do_tween(transitionScene, "modulate:a", endValue, duration)
	
	transitionScene.queue_free()

func _transition_circle(transitionType: Transition_Type, duration: float):
	var transitionScene = _add_transition_scene()
	var startValue = 1.0 if transitionType == Transition_Type.IN else 0.0
	var endValue = 0.0 if transitionType == Transition_Type.IN else 1.0
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = CIRCLE_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("circle_size", startValue)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/circle_size", endValue, duration)
	
	transitionScene.queue_free()

func _transition_diamond(transitionType: Transition_Type, duration: float,  diamondSize: float):
	var transitionScene = _add_transition_scene()
	var startValue = 0.0 if transitionType == Transition_Type.IN else 1.0
	var endValue = 1.0 if transitionType == Transition_Type.IN else 0.0
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = DIAMOND_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("diamondPixelSize", diamondSize)
	transitionScene.color_rect.material.set_shader_parameter("progress", startValue)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/progress", endValue, duration)
	
	transitionScene.queue_free()

func _transition_pixel(transitionType: Transition_Type, duration: float):
	var transitionScene = _add_transition_scene()
	var startValue = 1.6 if transitionType == Transition_Type.IN else 0.0
	var endValue = 0.0 if transitionType == Transition_Type.IN else 1.6
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = PIXEL_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("time", startValue)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/time", endValue, duration)
	
	transitionScene.queue_free()

func _transition_lines(transitionType: Transition_Type, duration: float, on_y_axis: bool):
	var transitionScene = _add_transition_scene()
	var startValue = 0.0 if transitionType == Transition_Type.IN else 1.0
	var endValue = 1.0 if transitionType == Transition_Type.IN else 0.0
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = LINIE_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("on_y_axis", on_y_axis)
	transitionScene.color_rect.material.set_shader_parameter("threshold", startValue)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/threshold", endValue, duration)
	
	transitionScene.queue_free()

func _transition_bar(transitionType: Transition_Type, duration: float, on_y_axis: bool):
	var transitionScene = _add_transition_scene()
	var startValue = 0.0 if transitionType == Transition_Type.IN else 1.0
	var endValue = 1.0 if transitionType == Transition_Type.IN else 0.0
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = BAR_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("on_y_axis", on_y_axis)
	transitionScene.color_rect.material.set_shader_parameter("threshold", startValue)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/threshold", endValue, duration)
	
	transitionScene.queue_free()

func _transition_radial(transitionType: Transition_Type, duration: float):
	var transitionScene = _add_transition_scene()
	var startValue = 0.0 if transitionType == Transition_Type.IN else 1.0
	var endValue = 1.0 if transitionType == Transition_Type.IN else 0.0
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = RADIAL_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("cooldown_progress", startValue)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/cooldown_progress", endValue, duration)
	
	transitionScene.queue_free()

func _transition_scribbles(transitionType: Transition_Type, duration: float):
	var transitionScene = _add_transition_scene()
	var startValue = 0.0 if transitionType == Transition_Type.IN else 1.0
	var endValue = 1.0 if transitionType == Transition_Type.IN else 0.0
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = DISOLVE_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("dissolve_texture", SCRIBBLES_IMAGE)
	transitionScene.color_rect.material.set_shader_parameter("amount", startValue)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/amount", endValue, duration)
	
	transitionScene.queue_free()
	
func _transition_paint_brush(transitionType: Transition_Type, duration: float,):
	var transitionScene = _add_transition_scene()
	var startValue = 0.0 if transitionType == Transition_Type.IN else 1.0
	var endValue = 1.0 if transitionType == Transition_Type.IN else 0.0
	
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = DISOLVE_SHADER
	
	transitionScene.color_rect.material.set_shader_parameter("dissolve_texture", HORIZ_PAINT_BRUSH)
	transitionScene.color_rect.material.set_shader_parameter("amount", startValue)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/amount", endValue, duration)
	
	transitionScene.queue_free()

func _transition_sweeping_diamond(transitionType: Transition_Type, duration: float,  diamondSize: float):
	var transitionScene = _add_transition_scene()
	var startValue = 0.0 if transitionType == Transition_Type.IN else 1.0
	var endValue = 1.0 if transitionType == Transition_Type.IN else 0.0
	
	transitionScene.color_rect.material = ShaderMaterial.new()
	transitionScene.color_rect.material.shader = SWEEPING_DIAMOND
	
	transitionScene.color_rect.material.set_shader_parameter("diamondPixelSize", diamondSize)
	transitionScene.color_rect.material.set_shader_parameter("progress", 1.0)
	
	await _do_tween(transitionScene.color_rect, "material:shader_parameter/progress", 0.0, duration)

	transitionScene.queue_free()

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
