@tool
extends ProfileItem
class_name NodeItem

@export var node_path: NodePath
@export var entries: Array[PropertyEntry] = []:
	set(p_entries):
		entries = p_entries
		_sync_targets()


func apply(preset: SceneProfileInterpretor.Presets) -> void:
	var target := get_target()
	for entry in entries:
		target.set(entry.property, entry.get_value(preset))


func get_target() -> Object:
	return interpretor.get_node_or_null(node_path)


func _sync_targets() -> void:
	if interpretor == null:
		return
	
	for entry in entries:
		if entry == null: continue
		entry.target = get_target()
