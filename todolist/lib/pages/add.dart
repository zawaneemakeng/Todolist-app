import 'package:flutter/material.dart';
//สำหรับ http method pckage
import 'dart:convert';
import 'package:http/http.dart' as http; //as http. ตั้งชื่อเล่น
import 'dart:async';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มรายการใหม่"),
        backgroundColor: Color.fromARGB(255, 193, 131, 221),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: ListView(
          children: [
            TextField(
              minLines: 2,
              maxLines: 3,
              controller: todo_title, //ลิงค์กับ text editing
              decoration: InputDecoration(
                  labelText: "รายการที่ต้องทำ", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              minLines: 5,
              maxLines: 10,
              controller: todo_detail, //ลิงค์กับ text editing
              decoration: InputDecoration(
                  labelText: "รายละเอียด", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            // ปุ่มเพิ่มข้อมูล
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  print('-----------');
                  print('title: ${todo_title.text}');
                  print('detail: ${todo_detail.text}');
                  postTodo();
                  setState(() {
                    todo_title.clear();
                    todo_detail.clear();
                  });
                },
                child: Text("เพิ่มรายการ"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 193, 131, 221)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(15, 10, 15, 10)),
                    textStyle:
                        MaterialStateProperty.all(TextStyle(fontSize: 20,fontFamily: 'taosuan'))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future postTodo() async {
    // var url = Uri.https('dea3-124-122-227-229.ap.ngrok.io', '/api/post-todolist') ;// use https
    var url = Uri.http(
        '192.168.2.36:8000', '/api/post-todolist'); //local host use http
    Map<String, String> header = {
      "Content-type": "application/json"
    }; //ค่าที่ต้องการส่งกลับบไปเป็นสตริง ประเภทดาต้าที่ส่งคือเจสัน เฮเดอร์ส่งเป็นเจสัน
    String jsondata =
        '{"title":"${todo_title.text}","detail":"${todo_detail.text}"}'; //ทดสอบส่ง
    var response = await http.post(url, headers: header, body: jsondata);
    print("----------------result--------------------");
    print(response.body);
  }
}
