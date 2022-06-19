import 'package:flutter/material.dart';
import 'package:todolist/pages/add.dart';

import 'dart:convert';
import 'package:http/http.dart' as http; //as http. ตั้งชื่อเล่น
import 'dart:async';

import 'package:todolist/pages/update_todolist.dart';

class Todolist extends StatefulWidget {
  const Todolist({Key? key}) : super(key: key);

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  //ใต้ state จะใส่่ตัวเเปร
  List todolistitems = ['A', 'B', 'C', 'D', 'E', 'F'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodolist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPage()))
              .then((value) {
            //เมื่อกดการ์ดจะวิ่งไปหน้าอัพเดต ถ้ากดคลิดเเล้วย้อนกลับมาให้ทำอะไร
            setState(() {
              getTodolist();
            });
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 193, 131, 221),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                getTodolist();
              });
            },
            icon: Icon(Icons.refresh),
          )
        ],
        title: Text('All Todolist'),
        backgroundColor: Color.fromARGB(255, 193, 131, 221),
      ),
      body: todolistCreate(),
    );
  }

  Widget todolistCreate() {
    return ListView.builder(
        itemCount: todolistitems.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            title: Text('${todolistitems[index]['title']}'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdatePage(
                            todolistitems[index]['id'],
                            todolistitems[index]['title'],
                            todolistitems[index]['detail'],
                          ))).then((value) {
                //เมื่อกดการ์ดจะวิ่งไปหน้าอัพเดต ถ้ากดคลิดเเล้วย้อนกลับมาให้ทำอะไร
                setState(() {
                  print(value);
                  if (value == 'delete') {
                    final snackBar = SnackBar(
                      content: const Text('ลบรายการเรียบร้อยเเล้ว'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  getTodolist();
                });
              });
            },
          ));
        });
  }

  Future<void> getTodolist() async {
    //ดึงข้อมมูลจาdatabase
    List alltodo = [];
    var url = Uri.http('192.168.2.36:8000', '/api/all-todolist');
    var response = await http.get(url);
    // var result = json.decode(response.body);//จะได้ลิซชุดนึง
    var result = utf8.decode(response.bodyBytes); //จะได้ลิซชุดนึง
    print(result);
    setState(() {
      todolistitems = jsonDecode(result);
    });
  }
}
