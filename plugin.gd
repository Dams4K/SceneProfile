@tool
extends EditorPlugin
class_name SceneProfilePlugin

const F_RELEASE = "template_release"

const S_SCENE_PROFILE = "scene_profile/%s"
const S_PRESET = S_SCENE_PROFILE % "preset"

var presets_button := PresetsButton.new()


static func get_preset() -> SceneProfileInterpretor.Presets:
	return ProjectSettings.get_setting(S_PRESET, SceneProfileInterpretor.Presets.MEDIUM)


func _enable_plugin() -> void:
	pass


func _disable_plugin() -> void:
	ProjectSettings.clear(S_PRESET)
	ProjectSettings.clear(get_setting_name(S_PRESET, F_RELEASE))
	ProjectSettings.save()


func _enter_tree() -> void:
	_add_preset_setting()
	_add_presets_button()


func _exit_tree() -> void:
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, presets_button)


func _add_preset_setting() -> void:
	var presets: Array = SceneProfileInterpretor.Presets.keys()
	for i in range(presets.size()):
		presets[i] = presets[i].capitalize()
	
	_add_setting(
		S_PRESET,
		SceneProfileInterpretor.Presets.MEDIUM,
		TYPE_INT,
		PROPERTY_HINT_ENUM,
		",".join(presets)
	)
	
	_add_setting(
		S_PRESET,
		SceneProfileInterpretor.Presets.MEDIUM,
		TYPE_INT,
		PROPERTY_HINT_ENUM,
		",".join(presets),
		F_RELEASE
	)


func _add_setting(name: String, value: Variant, type: int, hint: int = PROPERTY_HINT_NONE, hint_string: String = "", feature: String = "") -> void:
	var setting_name = get_setting_name(name, feature)
	if not ProjectSettings.has_setting(setting_name):
		ProjectSettings.set_setting(setting_name, value)
	
	ProjectSettings.add_property_info({
		name = setting_name,
		type = type,
		hint = hint,
		hint_string = hint_string
	})
	ProjectSettings.set_initial_value(setting_name, value)


static func get_setting_name(name: String, feature: String = "") -> String:
	return name if feature.is_empty() else "%s.%s" % [name, feature]


func _add_presets_button() -> void:
	presets_button.item_selected.connect(_on_presets_selected)
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, presets_button)


func _on_presets_selected(preset: SceneProfileInterpretor.Presets) -> void:
	ProjectSettings.set_setting(S_PRESET, preset)
	ProjectSettings.save()
	update_scenes()


static func update_scenes() -> void:
	var open_scenes := EditorInterface.get_open_scene_roots()
	for scene: Node in open_scenes:
		update_scene(scene)


static func update_current_scene() -> void:
	update_scene(EditorInterface.get_edited_scene_root())


static func update_scene(scene: Node) -> void:
	if scene == null:
		return
	
	var interpretors := scene.find_children("*", "SceneProfileInterpretor")
	for interpretor in interpretors:
		interpretor.apply()


class PresetsButton extends OptionButton:
	func _ready() -> void:
		add_theme_font_override("font", EditorInterface.get_editor_theme().get_font("bold", "EditorFonts"))
		
		for i in range(SceneProfileInterpretor.Presets.size()):
			var preset: String = SceneProfileInterpretor.Presets.keys()[i]
			add_item(preset.capitalize(), i)
		
		select(ProjectSettings.get_setting(S_PRESET, SceneProfileInterpretor.Presets.MEDIUM))
