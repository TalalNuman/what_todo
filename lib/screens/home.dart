import 'package:flutter/material.dart'; // import the material package
import '../constants/colors.dart'; // import the colors file
import '../widgets/todo_list_item.dart'; // import the todo list item file
import '../models/todo.dart'; // import the todo model file

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  final _searchText = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  SearchBox(),
                  Expanded(
                    child: Container(
                      // height: 300,
                      // ADJUST HEIGHT HERE

                      child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50, bottom: 20),
                            child: const Text("All Tasks",
                                style: TextStyle(
                                    color: tdBlack,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                          ),
                          for (ToDo todoo in _foundToDo.reversed)
                            ToDoListItem(
                              todo: todoo,
                              onToDoChanged: _handleToDoChange,
                              onDeleteItem: _deleteItem,
                            )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0)
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _todoController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                          hintText: 'Add a new task',
                          prefixIcon: Icon(
                            Icons.add,
                            color: tdBlue,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: tdBlue,
                        minimumSize: const Size(60, 60),
                        elevation: 10,
                      ),
                      onPressed: () {
                        _addToDoItem(_todoController.text);
                      },
                      child: const Text(
                        "+",
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, color: tdBlack, size: 30),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset('assets/images/profile.jpeg'),
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void _deleteItem(String id) {
    setState(() {
      todosList.removeWhere((todo) => todo.id == id);
    });
  }

  void _addToDoItem(String todo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: todo,
          isDone: false));
    });
    _todoController.clear();
  }

  void _runFilter(String searchText) {
    List<ToDo> results = [];
    if (searchText.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((todo) =>
              todo.title!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget SearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(0),
          hintText: 'Search',
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 25, maxHeight: 20),
        ),
      ),
    );
  }
}
