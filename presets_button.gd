@tool
extends OptionButton

func _ready() -> void:
	if Engine.is_editor_hint():
		add_theme_font_override("font", SceneProfilePluginHelper.get_editor_interface().get_editor_theme().get_font("bold", "EditorFonts"))
	
	for i in range(Presets.Quality.size()):
		var preset: String = Presets.Quality.keys()[i]
		add_item(preset.capitalize(), i)
	
	select(Presets.get_quality())
	
	item_selected.connect(_on_presets_selected)

func _on_presets_selected(quality: Presets.Quality) -> void:
	ProjectSettings.set_setting(Presets.S_PRESET, quality)
	ProjectSettings.save()
	SceneProfilePluginHelper.update_opened_scenes()
