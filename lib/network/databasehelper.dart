import 'dart:convert';
import 'package:cmsapp/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataBaseHelper {
  String serverIP = "http://192.168.43.103:3000/api";
  var status = false;
  String token;
  int loginStatus = 0;
  User user;
//////////login///////////
  login(String email, String password) async {
    Map data = {'email': email, 'password': password};
    var jsonData = null;
    final sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.post(
      Uri.parse('$serverIP/auth/customer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      print("okkkkkkkkkkkkkk");
      jsonData = json.decode(response.body);
      print(jsonData["token"].toString());
      save(jsonData["token"]);

      print("login successfuly 200 OK");

      print("Routing to your account");
      read();
    } else {
      print("login Error 101 ");
    }
    loginStatus = 200;
  }

/////////register////////
  void register(String firstName, String lastName, String email, String phone,
      String password) async {
    print(firstName);
    String role = '2';
    var jsonData = null;
    Map data = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
    };
    // String url = "$serverUrl/users/customer";
    final response = await http.post(
      Uri.parse('$serverIP/users/customer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(data),
    );

    status = response.body.contains('error');
    jsonData = json.decode(response.body);

    if (response.statusCode == 200) {
      print("okkkkkkkkkkkkkk");
      jsonData = json.decode(response.body);

      var datajson = jsonData["data"];
      print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11');
      print('dddddddddd ' + datajson.toString());
      print('dddddddddd ' + datajson['id'].toString());
      print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11');
      String fname = datajson['firstName'].toString();
      String lname = datajson['lastName'].toString();
      String email = datajson['email'].toString();
      String password = datajson['password'].toString();
      String phone = datajson['phone'].toString();
      String token = jsonData["token"].toString();
      int UserID = int.parse(datajson['id'].toString());

      user = new User(fname, lname, email, phone, UserID, password, token);

      print('all : //////////////////' +
          user.firstName.toString() +
          "   " +
          datajson['firstName'].toString() +
          "   " +
          datajson['lastName'].toString() +
          datajson['email'].toString() +
          datajson['phone'].toString() +
          datajson['id'].toString() +
          datajson['password'].toString() +
          jsonData["token"].toString());
      print('User fname : ' + user.getfirstName());
      print('User lname : ' + user.lastName.toString());
      print('User UserID : ' + user.UserID.toString());
      print('User password : ' + user.password.toString());
      print('User phone : ' + user.phone.toString());
    }
    if (status)
      print(response.body.toString());
    else
      print('jsondata : ${jsonData["token"]}');
    save(jsonData["token"]);
  }

  //////////getData/////////////
  Future<List> getData(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String url = "$serverIP/auth/customer";
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'token': '$value',
    });
    return json.decode(response.body);
  }

  ///////////save////////////
  save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

///////////read////////////
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read prefs : $value');
  }
}
