@tool
extends EditorPlugin
class_name SceneProfilePlugin

const S_SCENE_PROFILE = "scene_profile/%s"
const S_PRESET = S_SCENE_PROFILE % "preset"

func _enable_plugin() -> void:
	pass


func _disable_plugin() -> void:
	pass


func _enter_tree() -> void:
	if not ProjectSettings.has_setting(S_PRESET):
		ProjectSettings.set_setting(S_PRESET, SceneProfileInterpretor.Presets.MEDIUM)
	
	var presets: Array = SceneProfileInterpretor.Presets.keys()
	for i in range(presets.size()):
		presets[i] = presets[i].capitalize()
	
	ProjectSettings.add_property_info({
		name = S_PRESET,
		type = TYPE_INT,
		hint = PROPERTY_HINT_ENUM,
		hint_string = ",".join(presets)
	})
	ProjectSettings.set_initial_value(S_PRESET, SceneProfileInterpretor.Presets.MEDIUM)


func _exit_tree() -> void:
	ProjectSettings.clear(S_PRESET)
