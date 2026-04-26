@tool
extends EditorPlugin
class_name _SceneProfilePlugin

const HELPER_NAME = "SceneProfilePluginHelper"

var presets_button := PresetsButton.new()


func _enable_plugin() -> void:
	add_autoload_singleton(HELPER_NAME, "res://addons/scene_profile/scene_profile_plugin_helper.gd")


func _disable_plugin() -> void:
	ProjectSettings.clear(Presets.S_PRESET)
	ProjectSettings.clear(get_setting_name(Presets.S_PRESET, Presets.F_RELEASE))
	ProjectSettings.save()
	remove_autoload_singleton(HELPER_NAME)


func _enter_tree() -> void:
	_add_preset_setting()
	_add_presets_button()


func _exit_tree() -> void:
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, presets_button)


func _add_preset_setting() -> void:
	var presets: Array = Presets.Quality.keys()
	for i in range(presets.size()):
		presets[i] = presets[i].capitalize()
	
	_add_setting(
		Presets.S_PRESET,
		Presets.Quality.MEDIUM,
		TYPE_INT,
		PROPERTY_HINT_ENUM,
		",".join(presets)
	)
	
	_add_setting(
		Presets.S_PRESET,
		Presets.Quality.MEDIUM,
		TYPE_INT,
		PROPERTY_HINT_ENUM,
		",".join(presets),
		Presets.F_RELEASE
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
	if feature.is_empty():
		ProjectSettings.set_initial_value(setting_name, value)


static func get_setting_name(name: String, feature: String = "") -> String:
	return name if feature.is_empty() else "%s.%s" % [name, feature]


func _add_presets_button() -> void:
	presets_button.item_selected.connect(_on_presets_selected)
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, presets_button)


func _on_presets_selected(preset: Presets.Quality) -> void:
	ProjectSettings.set_setting(Presets.S_PRESET, preset)
	ProjectSettings.save()
	SceneProfilePluginHelper.update_opened_scenes()


class PresetsButton extends OptionButton:
	func _ready() -> void:
		add_theme_font_override("font", EditorInterface.get_editor_theme().get_font("bold", "EditorFonts"))
		
		for i in range(Presets.Quality.size()):
			var preset: String = Presets.Quality.keys()[i]
			add_item(preset.capitalize(), i)
		
		select(Presets.get_quality())
