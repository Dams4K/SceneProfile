@tool
extends ProfileItem
class_name NodeItem

@export var node_path: NodePath
@export var entries: Array[PropertyEntry] = []:
	set(p_entries):
		entries = p_entries
		_sync_targets()

func apply() -> void:
	pass


func _sync_targets() -> void:
	if SceneProfileInterpretor.instance == null:
		return
	
	for entry in entries:
		if entry == null: continue
		entry.target = SceneProfileInterpretor.instance.get_node_or_null(node_path)
