import 'package:flutter/material.dart';
import 'package:todolist/pages/todolist.dart';


void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todolist",
      home: const Todolist(),
      theme:  ThemeData(fontFamily: 'taosuan')
    );
  }
}