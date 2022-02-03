import 'dart:convert';
import 'package:cmsapp/models/user.dart';
import 'package:cmsapp/network/databasehelper.dart';
import 'package:http/http.dart' as http;
import 'package:cmsapp/screens/home.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/SignUpPage';
  final String serverAdd;
  final String port;
  SignUpPage(this.serverAdd, this.port, {Key key}) : super(key: key); //add a
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool checkBoxValue = false;

  double _height;

  double _width;

  double _pixelRatio;

  bool _large;

  bool _medium;

  // String serverIP = 'http://192.168.43.103:3000/api';
  DataBaseHelper dbhelper = new DataBaseHelper();
  final emailController = TextEditingController();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;

    _width = MediaQuery.of(context).size.width;

    _pixelRatio = MediaQuery.of(context).devicePixelRatio;

    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);

    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        body: Container(
          height: _height,

          width: _width,

          margin: EdgeInsets.only(bottom: 5),

          /// -----------------------------------------

          /// Build scrollable main content

          /// -----------------------------------------

          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                /// -----------------------------------------

                /// header Custom App Bar.

                /// -----------------------------------------

                Opacity(opacity: 0.88, child: CustomAppBar()),

                /// -----------------------------------------

                /// clip Shape widget for background.

                /// -----------------------------------------

                clipShape(),

                /// -----------------------------------------

                /// form user management.

                /// -----------------------------------------

                form(),

                /// -----------------------------------------

                /// accept Terms Text Row widget check box.

                /// -----------------------------------------

                acceptTermsTextRow(),

                SizedBox(
                  height: _height / 35,
                ),

                /// -----------------------------------------

                /// Sign in button.

                /// -----------------------------------------

                button(),

                /// -----------------------------------------

                /// text additional choice.

                /// -----------------------------------------

                infoTextRow(),

                /// -----------------------------------------

                /// buttons additional choice.

                /// -----------------------------------------

                // socialIconsRow(),

                //signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// -----------------------------------------

  /// clip Shape widget for background shape with helper method.

  /// -----------------------------------------

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            /// -----------------------------------------

            /// CustomShapeClipper for background shape.

            /// -----------------------------------------

            clipper: CustomShapeClipper(),

            child: Container(
              height: _large
                  ? _height / 8
                  : (_medium ? _height / 7 : _height / 6.5),
              decoration: BoxDecoration(
                color: Color.fromARGB(200, 8, 185, 220),
                // gradient: LinearGradient(
                //   colors: [Colors.orange[200], Colors.pinkAccent],
                // ),
              ),
            ),
          ),
        ),

        Opacity(
          opacity: 0.5,
          child: ClipPath(
            /// -----------------------------------------

            /// CustomShapeClipper2 for background shape.

            /// -----------------------------------------

            clipper: CustomShapeClipper2(),

            child: Container(
              height: _large
                  ? _height / 12
                  : (_medium ? _height / 11 : _height / 10),
              decoration: BoxDecoration(
                color: Color.fromARGB(200, 8, 185, 220),
                // gradient: LinearGradient(
                //   colors: [Colors.orange[200], Colors.pinkAccent],
                // ),
              ),
            ),
          ),
        ),

        Container(
          height: _height / 5.5,

          alignment: Alignment.center,

          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.0,
                  color: Colors.black26,
                  offset: Offset(1.0, 10.0),
                  blurRadius: 20.0),
            ],
            color: Colors.white,
            shape: BoxShape.circle,
          ),

          /// -----------------------------------------

          /// GestureDetector for adding  a photo.

          /// -----------------------------------------

          // child: GestureDetector(
          //     onTap: () {
          //       print('Adding photo');
          //     },
          //     child: Icon(
          //       //  Icons.add_a_photo,
          //       size: _large ? 40 : (_medium ? 33 : 31),
          //       color: Colors.orange[200],
          //     )),
        ),

//        Positioned(

//          top: _height/8,

//          left: _width/1.75,

//          child: Container(

//            alignment: Alignment.center,

//            height: _height/23,

//            padding: EdgeInsets.all(5),

//            decoration: BoxDecoration(

//              shape: BoxShape.circle,

//              color:  Colors.orange[100],

//            ),

//            child: GestureDetector(

//                onTap: (){

//                  print('Adding photo');

//                },

//                child: Icon(Icons.add_a_photo, size: _large? 22: (_medium? 15: 13),)),

//          ),

//        ),
      ],
    );
  }

  /// -----------------------------------------

  /// form for user management with helper method.

  /// -----------------------------------------

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            /// -----------------------------------------

            /// TextFormField for adding first Name.

            /// -----------------------------------------

            firstNameTextFormField(),

            SizedBox(height: _height / 60.0),

            /// -----------------------------------------

            /// TextFormField for adding last Name.

            /// -----------------------------------------

            lastNameTextFormField(),

            SizedBox(height: _height / 60.0),

            /// -----------------------------------------

            /// TextFormField for adding email.

            /// -----------------------------------------

            emailTextFormField(),

            SizedBox(height: _height / 60.0),

            /// -----------------------------------------

            /// TextFormField for adding phone.

            /// -----------------------------------------

            phoneTextFormField(),

            SizedBox(height: _height / 60.0),

            /// -----------------------------------------

            /// TextFormField for adding password.

            /// -----------------------------------------

            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    return CustomTextField(
      textEditingController: fnameController,
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "First Name",
    );
  }

  Widget lastNameTextFormField() {
    return CustomTextField(
      textEditingController: lnameController,
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "Last Name",
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      textEditingController: emailController,
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      hint: "Email ID",
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      textEditingController: phoneController,
      keyboardType: TextInputType.number,
      icon: Icons.phone,
      hint: "Mobile Number",
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      textEditingController: passController,
      keyboardType: TextInputType.text,
      obscureText: true,
      icon: Icons.lock,
      hint: "Password",
    );
  }

  Widget acceptTermsTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: Color.fromARGB(200, 8, 185, 220),
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          Text(
            "I accept all terms and conditions",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        register(fnameController.text, lnameController.text,
            emailController.text, phoneController.text, passController.text);
        print("******************* " +
            fnameController.text +
            " " +
            lnameController.text +
            " " +
            emailController.text +
            " " +
            phoneController.text +
            " " +
            passController.text);
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (BuildContext context) => MyHomePage()),
        //     (Route<dynamic> route) => false);
        print("Routing to your account");
        // User user = new User(fnameController.text, lnameController.text,
        //     emailController.text, passController.text, phoneController.text);
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,

//        height: _height / 20,

        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Color.fromARGB(200, 8, 185, 220),
        ),

        padding: const EdgeInsets.all(12.0),

        child: Text(
          'SIGN UP',
          style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
      ),
    );
  }

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
    String serverIP = 'http://' + widget.serverAdd + ':' + widget.port + '/api';
    final response = await http.post(
      Uri.parse('$serverIP/users/customer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(data),
    );

    var status = response.body.contains('error');
    jsonData = json.decode(response.body);
    // String dataHeader = json.decode(response.headers.values.toString());

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

      var user = new User(fname, lname, email, phone, UserID, password, token);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  MyHomePage(user, widget.serverAdd, widget.port)),
          (Route<dynamic> route) => false);
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
  }

  Widget infoTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Or create using social media",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  // Widget socialIconsRow() {
  //   return Container(
  //     margin: EdgeInsets.only(top: _height / 80.0),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         CircleAvatar(
  //           radius: 15,
  //           backgroundImage: AssetImage("assets/images/googlelogo.png"),
  //         ),
  //         SizedBox(
  //           width: 20,
  //         ),
  //         CircleAvatar(
  //           radius: 15,
  //           backgroundImage: AssetImage("assets/images/fblogo.jpg"),
  //         ),
  //         SizedBox(
  //           width: 20,
  //         ),
  //         CircleAvatar(
  //           radius: 15,
  //           backgroundImage: AssetImage("assets/images/twitterlogo.jpg"),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account?",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(200, 8, 185, 220),
                  fontSize: 19),
            ),
          )
        ],
      ),
    );
  }
}

//==================

// custom shape

//==================

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0.0, size.height - 70);

    var firstEndPoint = Offset(size.width * .5, size.height - 30.0);

    var firstControlpoint = Offset(size.width * 0.25, size.height - 50.0);

    path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 50.0);

    var secondControlPoint = Offset(size.width * .75, size.height - 10);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

class CustomShapeClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0.0, size.height - 20);

    var firstEndPoint = Offset(size.width * .5, size.height - 30.0);

    var firstControlpoint = Offset(size.width * 0.25, size.height - 50.0);

    path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 5);

    var secondControlPoint = Offset(size.width * .75, size.height - 20);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

//==================

//  Custom AppBar

//==================

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    double width = MediaQuery.of(context).size.width;

    return Material(
      child: Container(
        height: height / 10,
        width: width,
        padding: EdgeInsets.only(left: 15, top: 25),
        // decoration: BoxDecoration(
        //   gradient:
        //       LinearGradient(colors: [Colors.orange[200], Colors.pinkAccent]),
        // ),
        color: Color.fromARGB(200, 8, 185, 220),
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  print("pop");

                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }
}

//=====================

// Responsive Widget

//=====================

class ResponsiveWidget {
  static bool isScreenLarge(double width, double pixel) {
    return width * pixel >= 1440;
  }

  static bool isScreenMedium(double width, double pixel) {
    return width * pixel < 1440 && width * pixel >= 1080;
  }

  static bool isScreenSmall(double width, double pixel) {
    return width * pixel <= 720;
  }
}

//======================

//Custom TextField

//=====================

class CustomTextField extends StatelessWidget {
  final String hint;

  final TextEditingController textEditingController;

  final TextInputType keyboardType;

  final bool obscureText;

  final IconData icon;

  double _width;

  double _pixelRatio;

  bool large;

  bool medium;

  CustomTextField({
    this.hint,
    this.textEditingController,
    this.keyboardType,
    this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;

    _pixelRatio = MediaQuery.of(context).devicePixelRatio;

    large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);

    medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large ? 12 : (medium ? 10 : 8),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: keyboardType,
        cursorColor: Color.fromARGB(200, 8, 185, 220),
        decoration: InputDecoration(
          prefixIcon:
              Icon(icon, color: Color.fromARGB(200, 8, 185, 220), size: 20),
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
