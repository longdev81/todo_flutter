class Todo {
  final String id;
  final String name;
  final String currentTab;
  final bool status;

  Todo({
    required this.id,
    required this.name,
    required this.currentTab,
    required this.status,
  });

  Todo copyWith({String? id, String? name, String? currentTab, bool? status}) {
    return Todo(
      id: id ?? this.id,
      name: name ?? this.name,
      currentTab: currentTab ?? this.currentTab,
      status: status ?? this.status,
    );
  }
}
