@tool
extends EntriesItem
class_name ProjectSettingsItem

func _init() -> void:
	target = ProjectSettings

func _sync_targets() -> void:
	target = ProjectSettings
	super._sync_targets()


func set_property(entry: PropertyEntry, preset: SceneProfileInterpretor.Presets) -> void:
	var value = entry.get_value(preset)
	if value == null:
		return
	target.set_setting(entry.property, value)
