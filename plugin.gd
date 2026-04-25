@tool
extends EditorPlugin
class_name SceneProfilePlugin

const S_SCENE_PROFILE = "scene_profile/%s"
const S_PRESET = S_SCENE_PROFILE % "preset"

var presets_button := PresetsButton.new()

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
	
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, presets_button)


func _exit_tree() -> void:
	ProjectSettings.clear(S_PRESET)
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, presets_button)


class PresetsButton extends OptionButton:
	func _ready() -> void:
		for i in range(SceneProfileInterpretor.Presets.size()):
			var preset: String = SceneProfileInterpretor.Presets.keys()[i]
			add_item(preset.capitalize(), i)
		
		selected = ProjectSettings.get_setting(S_PRESET, 0) as int
