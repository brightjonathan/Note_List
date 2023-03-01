import 'package:flutter/material.dart';
import '../Screens/dialogueBox.dart';
import '../Widget/Task_Tile.dart';
import '../Model/dartModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Task_Screen extends StatefulWidget {
  const Task_Screen({Key? key}) : super(key: key);

  @override
  State<Task_Screen> createState() => _Task_ScreenState();
}

class _Task_ScreenState extends State<Task_Screen> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time ever opening the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }

    super.initState();
  }

  void checkBoxChange(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

//controller
  final _controller = TextEditingController();

  //save task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return dialogueBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add),
        onPressed: createNewTask,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: 60.0, bottom: 30.0, left: 30.0, right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.0,
                  child: Icon(Icons.list, color: Colors.deepOrange, size: 30.0),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Note List',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  db.toDoList.length == 0
                      ? 'No List Yet'
                      : db.toDoList.length == 1
                          ? '${db.toDoList.length.toString()} note list'
                          : '${db.toDoList.length.toString()} note lists',
                  style: const TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 300.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: ListView.builder(
                itemCount: db.toDoList.length,
                itemBuilder: (context, index) {
                  return todoTile(
                    taskName: db.toDoList[index][0],
                    taskCompleted: db.toDoList[index][1],
                    onChanged: (value) => checkBoxChange(value, index),
                    deleteFunction: (context) => deleteTask(index),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
