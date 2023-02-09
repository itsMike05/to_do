import 'package:flutter/material.dart';
import 'package:to_do/util/new_item_dialog.dart';
import '../util/todo_item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _dataBox = Hive.openBox('data_box');
  final _controller = TextEditingController();

  // List of todo items (expandable in the future)
  List toDoList = [
    ["Thing 1", false],
    ["To do 2", true],
    ["Last thing here", false]
  ];

  // Checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      // Reversing the checkbox state
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  // Create a new item
  void saveNewItem() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        toDoList.add([_controller.text, false]);
        _controller.clear();
      } else {
        Fluttertoast.showToast(
            msg: "Please add some text!", toastLength: Toast.LENGTH_LONG);
      }
    });
    Navigator.of(context).pop();
  }

  // Delete an existing item
  void deleteItem(int index) {
    setState(() {
      toDoList.removeAt(index);
      _controller.clear();
    });
  }

  // Create a new todo tile
  void createNewItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewItemDialog(
          controller: _controller,
          onSave: saveNewItem,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        elevation: 5,
        title: const Center(
          child: Text(
            "YUP, ANOTHER TO DO APP",
            style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 15, letterSpacing: 5),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewItem,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoItem(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteItem: (context) => deleteItem(index),
          );
        },
      ),
    );
  }
}
