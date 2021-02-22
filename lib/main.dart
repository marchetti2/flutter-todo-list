import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo-List',
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Todo-List'),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
        ),
        body: Text("Oi"),
      ),
    );
  }
}
