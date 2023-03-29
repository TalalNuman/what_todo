import 'package:flutter/material.dart';
import 'package:what_todo/constants/colors.dart';
import 'package:what_todo/models/todo.dart';

class ToDoListItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoListItem(
      {Key? key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteItem})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () {
            onToDoChanged(todo);
          },
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          tileColor: Colors.white,
          leading: Icon(
              todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
              color: tdBlue),
          title: Text(
            todo.title!,
            style: TextStyle(
              color: tdBlack,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              decoration: todo.isDone! ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: tdRed, borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              onPressed: () {
                onDeleteItem(todo.id);
              },
              icon: Icon(Icons.delete),
              color: Colors.white,
              iconSize: 18,
            ),
          ),
        ));
  }
}
