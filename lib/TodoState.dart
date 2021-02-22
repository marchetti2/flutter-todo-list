import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  @override
  State createState() => TodoState();
}

class Task {
  String task;
  bool done;

  Task(this.task, this.done);

  @override
  String toString() {
    return '{ ${this.task}, ${this.done} }';
  }
}

class TodoState extends State<Todo> {
  final TextEditingController taskController = TextEditingController();
  List<Task> _todoList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Form(
                  child: Row(
                children: [
                  Expanded(
                      child: Container(
                    color: Colors.white,
                    child: TextFormField(
                      controller: taskController,
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        hintText: 'Enter your task',
                        hintStyle:
                            TextStyle(fontSize: 20, color: Colors.grey[400]),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  )),
                  Container(
                      height: 50,
                      width: 55,
                      margin: EdgeInsets.only(left: 15),
                      child: ElevatedButton(
                          onPressed: () {
                            if (taskController.text.isEmpty) {
                              return ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(milliseconds: 700),
                                  content: Text("Type something"),
                                ),
                              );
                            }
                            setState(() {
                              _todoList.add(Task(taskController.text, false));
                            });
                            taskController.clear();
                          },
                          child: Icon(Icons.add, size: 18),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange))),
                ],
              )),
            ),
            Divider(color: Colors.black12),
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: ReorderableListView(
                      children: List.generate(_todoList.length, (index) {
                        final todo = _todoList[index];
                        final task = _todoList[index].task;
                        final done = _todoList[index].done;

                        return Card(
                            key: ValueKey(index),
                            elevation: 0,
                            child: Dismissible(
                              //movementDuration: Duration(milliseconds: 200),
                              //resizeDuration: Duration(milliseconds: 200),

                              key: Key(task),
                              confirmDismiss: (direction) {
                                if (direction == DismissDirection.endToStart) {
                                  setState(() {
                                    _todoList.removeAt(index);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      duration: Duration(milliseconds: 2000),
                                      content: Text("$task as removed"),
                                      action: SnackBarAction(
                                          label: 'UNDO',
                                          onPressed: () {
                                            setState(() {
                                              _todoList.insert(
                                                  index, Task(task, done));
                                            });
                                          }),
                                    ),
                                  );
                                }

                                if (direction == DismissDirection.startToEnd) {
                                  if (done == false) {
                                    setState(() {
                                      _todoList[index].done = true;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(milliseconds: 2000),
                                        content: Text("Task completed"),
                                        action: SnackBarAction(
                                          label: 'UNDO',
                                          onPressed: () {
                                            setState(() {
                                              _todoList[index].done = false;
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  setState(() {
                                    _todoList[index].done = false;
                                  });
                                }
                                return null;
                              },
                              background: Container(
                                  color: Colors.green,
                                  child: Align(
                                    alignment: Alignment(-0.9, 0),
                                    child:
                                        Icon(Icons.check, color: Colors.white),
                                  )),
                              secondaryBackground: Container(
                                color: Colors.red,
                                child: Align(
                                  alignment: Alignment(0.9, 0),
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                ),
                              ),
                              child: Container(
                                  color: todo.done == false
                                      ? Colors.white
                                      : Colors.grey[100],
                                  child: ListTile(
                                      onTap: () {},
                                      title: done == false
                                          ? Text(task)
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  task,
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                                Icon(Icons.check,
                                                    color: Colors.teal)
                                              ],
                                            ))),
                            ));
                      }),
                      onReorder: _handleReorder,
                    )))
          ],
        ));
  }

  void _handleReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final todo = _todoList.removeAt(oldIndex);
      _todoList.insert(newIndex, todo);
    });
  }
}
