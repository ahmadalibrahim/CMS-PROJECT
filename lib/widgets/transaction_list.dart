import 'package:cmsapp/models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'detailes.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';

//add data to widgets
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final User user;
  final String port;
  final String serverAdd;

  @override
  // noSuchMethod(Invocation invocation) {
  //   // TODO: implement noSuchMethod
  //   return super.noSuchMethod(invocation);
  // }

  TransactionList(this.transactions, this.user, this.serverAdd, this.port);
  // String serverIP = 'http://192.168.43.103:3000/api';

  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                'there is no complaints ...!',
                style: Theme.of(context).textTheme.body1,
              ),
              SizedBox(
                height: 0,
              ),
              Container(
                // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                // padding: EdgeInsets.all(50),
                height: 200,
                // child: Image.asset(
                //   'assets/images/Logo.JPG',
                //   fit: BoxFit.cover,
                // ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Container(
                child: GestureDetector(
                  onTap: () {
                    getData(transactions[index].id.toString(), context,
                        transactions[index]);
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                    elevation: 6,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text(
                              transactions[index].id.toString(),
                              style: TextStyle(
                                fontSize: 16 * curScaleFactor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        transactions[index].date.toString(),
                        //  transactions[index].status.toString(),
                        style: TextStyle(fontSize: 14 * curScaleFactor),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }

  getData(String id, BuildContext context, Transaction transaction) async {
    String serverIP = 'http://' + serverAdd + ':' + port + '/api';
    print(serverIP);
    var jsonData;
    var response = await http.get(
      Uri.parse('$serverIP/complaint/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        // 'x-auth-token': '$pref'
        //
      },
    );
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      double progress = double.parse(jsonData["progress"].toString());
      String status = jsonData["status"].toString();
      String reply = jsonData["reply"].toString();
      print("jsonData : " + jsonData.toString());
      print("compliant add successfuly 200 OK");
      print("id++++++++++++++" +
          progress.toString() +
          "+++++++++++++++++++++++++++++");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => DetailsComplaint(
                transaction, user, progress, serverAdd, port, status, reply),
          ),
          (Route<dynamic> route) => false);
    } else
      print("compliant added Error 101 ");
  }
}
