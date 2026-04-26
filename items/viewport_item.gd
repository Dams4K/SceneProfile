@tool
extends EntriesItem
class_name ViewportItem

func get_viewport() -> Viewport:
	if get_local_scene() == null: return null
	return get_local_scene().get_viewport()

func apply(quality: Presets.Quality) -> void:
	target = get_viewport()
	if target == null:
		print("retur")
		return
	super.apply(quality)

func _sync_targets() -> void:
	target = get_viewport()
	super._sync_targets()
