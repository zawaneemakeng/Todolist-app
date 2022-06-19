import 'package:flutter/material.dart';
//สำหรับ http method pckage

import 'dart:convert';
import 'package:http/http.dart' as http; //as http. ตั้งชื่อเล่น
import 'dart:async';

class UpdatePage extends StatefulWidget {
  final v1,v2,v3;
  const UpdatePage(this.v1,this.v2,this.v3);

  @override
  
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var _v1, _v2, _v3;
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
    void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1;//id
    _v2 = widget.v2;//title
    _v3 = widget.v3;//detail
    todo_title.text = _v2;
    todo_detail.text = _v3;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เเก้ไข"),
        backgroundColor: Color.fromARGB(255, 193, 131, 221),
        actions: [
          IconButton(onPressed: (){
            print("Delete ID : $_v1");
            deleteTodo();
            Navigator.pop(context,'delete');
             // pop ให้กดเเบกเอง
          },icon: Icon(Icons.delete),
          )
        ],
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
                  updateTodo();
                  final snackBar = SnackBar(
                      content: const Text('อัพเดตรายการเรียบร้อยเเล้ว'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text("เเก้ไข"),
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

  Future updateTodo() async {
    // var url = Uri.https('dea3-124-122-227-229.ap.ngrok.io', '/api/post-todolist') ;//local host use http
    var url = Uri.http(
        '192.168.2.36:8000', '/api/update-todolist/$_v1'); //local host use http
    Map<String, String> header = {
      "Content-type": "application/json"
    }; //ค่าที่ต้องการส่งกลับบไปเป็นสตริง ประเภทดาต้าที่ส่งคือเจสัน เฮเดอร์ส่งเป็นเจสัน
    String jsondata =
        '{"title":"${todo_title.text}","detail":"${todo_detail.text}"}'; //ทดสอบส่ง
    var response = await http.put(url, headers: header, body: jsondata);
    print("----------------result--------------------");
    print(response.body);
  }
  
  Future deleteTodo()async{
    var url = Uri.http(
        '192.168.2.36:8000', '/api/delete-todolist/$_v1');
    Map<String, String> header = {
      "Content-type": "application/json"};
    var response = await http.delete(url, headers: header,);
    print("----------------result--------------------");
    print(response.body);


  }
}
