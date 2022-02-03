import 'package:cmsapp/models/user.dart';
import 'package:cmsapp/screens/home.dart';
import 'package:cmsapp/screens/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class DetailsComplaint extends StatelessWidget {
  static const routeName = '/DetailsComplaint';
  final Transaction compliant;
  final User user;
  final double progress;
  final String port;
  final String serverAdd;
  final String status;
  final String reply;

  DetailsComplaint(this.compliant, this.user, this.progress, this.serverAdd,
      this.port, this.status, this.reply,
      {Key key})
      : super(key: key); //add a
  @override
  Widget build(BuildContext context) {
    // Transaction CompliantId = ModalRoute.of(context).settings.arguments;
    // print(" CompliantId" + CompliantId.toString());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MyHomePage(user, serverAdd, port)),
              (Route<dynamic> route) => false),
        ),
        backgroundColor: Colors.blue,
        title: Text(" # " + compliant.id.toString()),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.all(3),
          child: ListView(
            children: <Widget>[
              Center(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: new LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 2500,
                        // percent: bldoue.parse((compliant.cost).toString()),
                        percent: progress,
                        center: Text(
                          "" + (progress * 100).toInt().toString() + '%',
                          style: new TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Color.fromARGB(500, 210, 101, 12)),
                  ),
                ),
              ),
              //detailes
              Container(
                padding: EdgeInsets.only(
                  bottom: 10,
                  top: 12,
                  left: 12,
                  right: 12,
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(500, 210, 101, 12),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //     child: RichText(
                    //   text: TextSpan(
                    //     children: [
                    //       TextSpan(
                    //         text: "Click ",
                    //       ),
                    //       WidgetSpan(
                    //         child: Icon(Icons.add, size: 14),
                    //       ),
                    //       TextSpan(
                    //         text: " to add",
                    //       ),
                    //     ],
                    //   ),
                    // )),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: RichText(
                        text: new TextSpan(
                          style: new TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.list_alt_outlined,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                                text: ' Title :  ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                            new TextSpan(
                              text: compliant.title,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      child: const DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.white),
                      ),
                      height: 2,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: RichText(
                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: new TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.list_alt_outlined,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            new TextSpan(
                                text: ' Description :  ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                            new TextSpan(text: compliant.discription),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: RichText(
                            text: new TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.date_range_outlined,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                new TextSpan(
                                    text: ' Date :  ',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold)),
                                new TextSpan(
                                  text: DateFormat.yMMMd()
                                      .format(compliant.date)
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /////////Status//////////
                        Container(
                          margin: EdgeInsets.all(5),
                          child: RichText(
                            text: new TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.info_outlined,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                new TextSpan(
                                    text: ' Status :  ',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold)),
                                new TextSpan(
                                  text: status,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: const DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                ),
                height: 7,
              ),

/////////////////
              // Response////////////////
              Container(
                padding: EdgeInsets.only(
                  bottom: 12,
                  top: 12,
                  left: 12,
                  right: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Color.fromARGB(50, 5, 200, 155),
                ),
                child: new RichText(
                  text: new TextSpan(
                    style: new TextStyle(fontSize: 16.0, color: Colors.black),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.quickreply_outlined,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                      new TextSpan(
                          text: ' Reply :  ',
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                      new TextSpan(
                        text: " " + reply,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 12, top: 10),
                child: Text(
                  'The cost is ' +
                      compliant.cost +
                      ' , Are you sure  to continue ?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      // width: MediaQuery.of(context).size.width,

                      // margin:
                      //     EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                      padding: const EdgeInsets.all(12.0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        child: Container(
                          height: 20,
                          child: Text('Yes'),
                        ),
                        elevation: 0,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        onPressed: () {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Login Successful'),
                            duration: Duration(
                              milliseconds: 750,
                            ),
                          ));
                        },
                      ),
                    ),
                    Container(
                      // width: MediaQuery.of(context).size.width,
                      // alignment: Alignment.center,
                      // margin:
                      //     EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                      padding: const EdgeInsets.all(12.0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        child: Container(
                          height: 20,
                          child: Text('No'),
                        ),
                        elevation: 0,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              //admin response
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------------------------

///   Model for list item  drawer .

/// ---------------------------

// <Null> means this route returns nothing.
