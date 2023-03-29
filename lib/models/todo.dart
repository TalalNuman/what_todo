class ToDo {
  String? id;
  String? title;
  bool? isDone;

  ToDo({
    required this.id,
    required this.title,
    this.isDone = false,
  });
  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', title: 'Morning Excercise', isDone: true),
      ToDo(id: '02', title: 'Buy Groceries', isDone: true),
      ToDo(
        id: '03',
        title: 'Check Emails',
      ),
      ToDo(
        id: '04',
        title: 'Team Meeting',
      ),
      ToDo(
        id: '05',
        title: 'Work on mobile apps for 2 hour',
      ),
      ToDo(
        id: '06',
        title: 'Dinner with Jenny',
      ),
    ];
  }
}
