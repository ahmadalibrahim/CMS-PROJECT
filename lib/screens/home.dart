import 'dart:convert';
import 'package:cmsapp/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:cmsapp/models/transaction.dart';
import 'package:cmsapp/screens/sign_in.dart';
import 'package:cmsapp/widgets/new_transaction.dart';
import 'package:cmsapp/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/MyHomePage';
  final User user;
  final String serverAdd;
  final String port;

  MyHomePage(this.user, this.serverAdd, this.port, {Key key})
      : super(key: key); //add a
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // String serverIP = 'http://192.168.43.103:3000/api';

  final List<Transaction> userTransaction = [
    //  Transactin(name: 'Ahmad', id: '155', date: DateTime.now()),
    // Transaction(name: 'Ali', id: '133', date: DateTime.now()),
  ];

  void addNewTransaction(String title, String enteredDiscrption, int compId,
      String status, String cost) {
    final newTX = Transaction(
      title: title,
      id: compId,
      date: DateTime.now(),
      status: status,
      discription: enteredDiscrption,
      cost: cost,
    );
    print("in add:  " + title + " " + compId.toString() + "  ");
    setState(() {
      userTransaction.add(newTX);
    });
  }

  //show input area
  void _starAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(addNewTransaction, widget.user.UserID,
              widget.serverAdd, widget.port),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    String port = widget.serverAdd;
    getData();
    final appBar = AppBar(
      title: Text("Complaints List"),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _starAddNewTransaction(context))
      ],
    );
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),

              accountName: Text('' + widget.user.firstName),

              accountEmail: Text('' + widget.user.email),

              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
              ),

              /// ---------------------------

              ///   Building drawer header .

              /// ---------------------------
            ),
            ListTile(
              title: Text('About Us'),
            ),
            SizedBox(
              child: const DecoratedBox(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(187, 189, 216, 100)),
              ),
              height: 2,
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignInScreen()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.start,// is a default  config in flutter
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0,
              // child: Chart(_recentTransactions),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  1,
              child: TransactionList(
                  userTransaction, widget.user, widget.serverAdd, widget.port),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _starAddNewTransaction(context),
          child: Icon(Icons.add)),
    );

    /// ---------------------------

    ///   Building drawer items list  .

    /// ---------------------------
  }

  String getaddress() {
    return widget.serverAdd;
  }

  void getData() async {
    String serverIP = 'http://' + widget.serverAdd + ':' + widget.port + '/api';
    // Map data = {
    //   'data': {'title': title, 'discription': discription},
    String userId = widget.user.UserID.toString();
    // };
    List jsonData;
    var response = await http.get(
      Uri.parse('$serverIP/complaint/my/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        // 'x-auth-token': '$pref'
        //
      },
      // body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      // CompliantList cc = new CompliantList();
      // cc.getList(jsonData);
      for (var i = 0; i < jsonData.length; i++) {
        // var d = jsonData[i].toString();
        //// print(d);
        var djson = jsonData[i];
        var datajson = djson["data"];
        // print(datajson["title"].toString());
        // print(djson["data"].toString());

/////////////////////////////////////get data from json
        Transaction tt = new Transaction();
        tt.title = datajson["title"].toString();
        tt.discription = datajson["discription"].toString();
        tt.id = int.parse(djson["id"].toString());
        tt.status = djson["status"].toString();
        tt.date = DateTime.parse(djson["createdAt"].toString());
        tt.cost = datajson["cost"].toString();

        print('id  ' +
            tt.id.toString() +
            '  + title ' +
            tt.title +
            '+ discription   ' +
            tt.discription +
            '+ date  ' +
            tt.date.toString() +
            '+++++++++++++++++' +
            tt.cost.toString() +
            '+++++++++++++++++' +
            jsonData.length.toString() +
            '+++++++++++++++');
        print('////////////////////////////////////////////////////');
        int x = findPersonUsingWhere(userTransaction, tt.id);
        // addNewTransaction('111', '222', 333, '444');
        if (x == 0)
          addNewTransaction(
              datajson["title"].toString(),
              datajson["discription"].toString(),
              int.parse(djson["id"].toString()),
              datajson["discription"].toString(),
              datajson["cost"].toString());
        else
          print('not added');
      }

      // print(_userTransaction.toString());
      print("compliant add successfuly 200 OK");

      print("compliant add successfuly 200 OK");

      ////////////////////
      // for (var i = 0; i < userTransaction.length; i++) {
      //   print(" transactions for  : " + userTransaction[i].toString());
      //   print('------------------------------------------------------');
      // }

      print('------------------------------------------------------');
      print("compliant : " + jsonData.toString());
    } else
      print("compliant added Error 101 ");
  }

  int findPersonUsingWhere(var people, int personId) {
    // Return list of people matching the condition
    final foundPeople = people.where((element) => element.id == personId);
    // print("foundPeople" + foundPeople.toString());
    // Transaction ss = new Transaction();
    // ss = foundPeople[0];
    if (foundPeople.isNotEmpty) {
      // print("ssssssssssssssss" + ss.title);
      return 1;
    } else
      return 0;
  }
}
