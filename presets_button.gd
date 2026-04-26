extends OptionButton

func _ready() -> void:
	add_theme_font_override("font", EditorInterface.get_editor_theme().get_font("bold", "EditorFonts"))
	
	for i in range(Presets.Quality.size()):
		var preset: String = Presets.Quality.keys()[i]
		add_item(preset.capitalize(), i)
	
	select(Presets.get_quality())
	
	item_selected.connect(_on_presets_selected)

func _on_presets_selected(preset: Presets.Quality) -> void:
	ProjectSettings.set_setting(Presets.S_PRESET, preset)
	ProjectSettings.save()
	SceneProfilePluginHelper.update_opened_scenes()
