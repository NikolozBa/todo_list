class TodoItem {
  String title;
  String task;
  String description;
  bool completed;

  TodoItem({
    required this.title,
    required this.task,
    required this.description,
    required this.completed});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['task'] = this.task;
    data['description'] = this.description;
    data['completed']=this.completed;
    return data;
  }
}