@tool
extends Node

func get_editor_interface() -> Object:
	return Engine.get_singleton("EditorInterface")

func get_plugin() -> Object:
	if not Engine.is_editor_hint():
		return null
	var plugins = get_editor_interface().get_base_control().find_children("*", "EditorPlugin", true, false)
	for p in plugins:
		if p.get_script() and p.get_script().get_global_name() == "SceneProfilePlugin":
			return p
	return null


func update_opened_scenes() -> void:
	if not Engine.is_editor_hint(): return
	var open_scenes = get_editor_interface().get_open_scene_roots()
	for scene in open_scenes:
		update_scene(scene)


func update_current_scene() -> void:
	if Engine.is_editor_hint():
		update_scene(get_editor_interface().get_edited_scene_root())
	elif is_inside_tree():
		update_scene(get_tree().current_scene)


func update_scene(scene: Node) -> void:
	if scene == null:
		return
	
	var interpretors := scene.find_children("*", "SceneProfileInterpretor")
	for interpretor in interpretors:
		interpretor.apply()


func popup_property_selector(object: Object, callback: Callable, type_filter: PackedInt32Array = PackedInt32Array(), current_value: String = "") -> void:
	if not Engine.is_editor_hint(): return
	var editor_interface = get_editor_interface()
	if editor_interface == null: return
	editor_interface.popup_property_selector(object, callback, type_filter, current_value)


func popup_method_selector(object: Object, callback: Callable, current_value: String = "") -> void:
	if not Engine.is_editor_hint(): return
	var editor_interface = get_editor_interface()
	if editor_interface == null: return
	editor_interface.popup_method_selector(object, callback, current_value)
