@abstract
extends Object
class_name Presets

const F_RELEASE = "template_release"

const S_SCENE_PROFILE = "scene_profile/%s"
const S_PRESET = S_SCENE_PROFILE % "preset"


enum Quality {
	LOW,
	MEDIUM,
	HIGH,
	ULTRA
}


static func get_quality() -> Quality:
	var quality = ProjectSettings.get_setting_with_override(S_PRESET)
	print(quality)
	print(ProjectSettings.has_setting("scene_profile/preset"))
	print(OS.has_feature("template_release"))
	print(OS.has_feature("template_debug"))
	print(ProjectSettings.get_setting("scene_profile/preset"))
	print(ProjectSettings.get_setting("scene_profile/preset.template_release"))
	return quality if quality != null else Quality.MEDIUM
