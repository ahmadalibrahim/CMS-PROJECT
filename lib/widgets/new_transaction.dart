import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//have text field card
class NewTransaction extends StatefulWidget {
  final Function addTx;
  int userid;
  final String serverAdd;
  final String port;
  NewTransaction(this.addTx, this.userid, this.serverAdd, this.port);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //String serverIP = 'http://192.168.43.103:3000/api';
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  int compliantId;
  // List<String> listOfComplaintType = [
  //   'The USA',
  //   'England',
  //   'Syria',
  //   'Canada',
  // ];
  // String selectedIndexCountry = 'The USA';
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredDescription = descriptionController.text;
    if (enteredTitle.isEmpty || enteredDescription.isEmpty) {
      return;
    } else {
      print("widget.userid" + widget.userid.toString());
      getData(enteredTitle, enteredDescription, widget.userid);
    }

    Navigator.of(context).pop();
  }

  getData(String title, String discription, int userid) async {
    Map data = {
      'data': {'title': title, 'discription': discription},
      'userId': userid
    };
    var jsonData = null;
    String serverIP = 'http://' + widget.serverAdd + ':' + widget.port + '/api';
    var response = await http.post(
      Uri.parse('$serverIP/complaint/customer/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        // 'x-auth-token': '$pref'
        //
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      compliantId = jsonData["id"];
      print("compliant : " + jsonData.toString());
      print("compliant add successfuly 200 OK");
      print("id++++++++++++++" +
          compliantId.toString() +
          "+++++++++++++++++++++++++++++");
      print('compliant id : ${jsonData["id"]}');
      widget.addTx(title, discription, compliantId, 'aaaaa');
    } else
      print("compliant added Error 101 ");
  }

  Future<String> read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read prefs : $value');
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            //title text field
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14 * curScaleFactor,
                  color: Colors.pink),
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submitData(),
            ),

            SizedBox(
              //width: ,
              height: 10,
              //  child: Card(child: Text('Hello World!')),
            ),
            //description text field
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14 * curScaleFactor,
                  color: Colors.pink),
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: submitData, //onPressed
              child: Text('Add Complaint'),

              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}
