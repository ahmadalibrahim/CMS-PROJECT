import 'dart:convert';
import 'package:cmsapp/models/user.dart';
import 'package:cmsapp/network/databasehelper.dart';
import 'package:cmsapp/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/SignInScreen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String msgstatus;
  double _height;
  var _passwordVisible = false;
  double _width;

  double _pixelRatio;

  bool _large;

  bool _medium;
  User user;
  String userAuth;

  DataBaseHelper dbhelper = new DataBaseHelper();
  TextEditingController emailController = TextEditingController();
  TextEditingController serverAddressController = TextEditingController();
  TextEditingController portController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // String serverIP = 'http://192.168.43.103:3000/api';

  GlobalKey<FormState> _key = GlobalKey();

  /// -----------------------------------------

  /// Build main content with responsive size with help of mediaQuery

  /// -----------------------------------------

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;

    _width = MediaQuery.of(context).size.width;

    _pixelRatio = MediaQuery.of(context).devicePixelRatio;

    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);

    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Server IP '),
            ),
            SizedBox(
              height: 10,
            ),
            serverAddress(),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text('Server port'),
            ),
            port(),
          ],
        ),
      ),
      body: Container(
        height: _height,

        width: _width,

        padding: EdgeInsets.only(bottom: 5),

        /// -----------------------------------------

        /// Build scrollable main content

        /// -----------------------------------------

        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              /// -----------------------------------------

              /// header Custom background shape.

              /// -----------------------------------------

              clipShape(),

              /// -----------------------------------------

              /// welcome Text Row.

              /// -----------------------------------------

              welcomeTextRow(),

              /// -----------------------------------------

              ///  sign In Text Row.

              /// -----------------------------------------

              signInTextRow(),

              /// -----------------------------------------

              /// form user management.

              /// -----------------------------------------

              form(),

              /// -----------------------------------------

              /// forget Pass Text Row.

              /// -----------------------------------------

              forgetPassTextRow(),

              SizedBox(height: _height / 12),

              /// -----------------------------------------

              /// forget Pass Text Row.

              /// -----------------------------------------

              loignButton(),

              /// -----------------------------------------

              /// sign Up Text Row.

              /// -----------------------------------------

              signUpTextRow(serverAddressController.text, portController.text),
            ],
          ),
        ),
      ),
    );
  }

  /// -----------------------------------------

  /// background shape background .

  /// -----------------------------------------

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;

    /// -----------------------------------------

    /// Build main content with stack widget.

    /// -----------------------------------------

    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            /// -----------------------------------------

            /// Custom Shape Clipper background.

            /// -----------------------------------------

            clipper: CustomShapeClipper(),

            child: Container(
              height: _large
                  ? _height / 4
                  : (_medium ? _height / 3.75 : _height / 3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Colors.blueGrey, Colors.lightBlue],
                ),
              ),
            ),
          ),
        ),

        Opacity(
          opacity: 0.5,
          child: ClipPath(
            /// -----------------------------------------

            /// Custom Shape Clipper2 background.

            /// -----------------------------------------

            clipper: CustomShapeClipper2(),

            child: Container(
              height: _large
                  ? _height / 4.5
                  : (_medium ? _height / 4.25 : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Colors.blueGrey, Colors.lightBlue],
                ),
              ),
            ),
          ),
        ),

        /// -----------------------------------------

        /// Header main image.

        /// -----------------------------------------

        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
              top: _large
                  ? _height / 30
                  : (_medium ? _height / 25 : _height / 20)),
          //   child: Image.network(
          // //    Constants.images[0],
          //     height: _height / 3.5,
          //     width: _width / 3.5,
          //   ),
        ),
      ],
    );
  }

  /// -----------------------------------------

  /// welcome Text Row widget with helper method.

  /// -----------------------------------------

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[
          Text(
            "CMS",
            style: TextStyle(
              color: Color.fromARGB(200, 8, 185, 220),
              fontWeight: FontWeight.bold,
              fontSize: _large ? 60 : (_medium ? 50 : 40),
            ),
          ),
        ],
      ),
    );
  }

  /// -----------------------------------------

  /// signIn Text Row widget with helper method.

  /// -----------------------------------------

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Sign in to your account",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: _large ? 20 : (_medium ? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  /// -----------------------------------------

  /// form for entering email and password text field  with helper method.

  /// -----------------------------------------

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            /// -----------------------------------------

            /// email Text Form Field  with helper method.

            /// -----------------------------------------

            emailTextFormField(),

            SizedBox(height: _height / 50.0),

            /// -----------------------------------------

            /// password Text Form Field  with helper method.

            /// -----------------------------------------

            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  /// -----------------------------------------

  /// email Text Form Field  with helper method.

  /// -----------------------------------------

  // Widget emailTextFormField() {
  //   return TextFormField(
  //     keyboardType: TextInputType.emailAddress,
  //     textEditingController: emailController,
  //     icon: Icons.email,
  //     hint: "Email ID",
  //   );
  // }
  Widget emailTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: emailController,
      decoration: InputDecoration(
        prefixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            Icons.email,
            color: Colors.lightBlue,
          ),
          onPressed: () {},
        ),
        // prefixIcon: (icon:Icon(Icons.lock)),
        labelText: 'Email',
        hintText: 'Enter Email',
        // Here is key idea
      ),
    );
  }

  /// -----------------------------------------

  /// email Text Form Field  with helper method.

  /// -----------------------------------------

  Widget passwordTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,

      controller: passwordController,
      obscureText: !_passwordVisible, //This will obscure text dynamically
      decoration: InputDecoration(
        prefixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            Icons.lock,
            color: Colors.lightBlue,
          ),
          onPressed: () {},
        ),
        // prefixIcon: (icon:Icon(Icons.lock)),
        labelText: 'Password',
        hintText: 'Enter your password',
        // Here is key idea
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.lightBlue,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }

  Widget serverAddress() {
    return CustomTextField(
      hint: "127.0.0.1 ",
      textEditingController: serverAddressController,
      keyboardType: TextInputType.number,
      // serverIp
    );
  }

  Widget port() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      textEditingController: portController,
      hint: "3000",
    );
  }

  /// -----------------------------------------

  /// forget Pass Text Row  with helper method.

  /// -----------------------------------------

  Widget forgetPassTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Forgot your password?",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              print("Routing");
            },
            child: Text(
              "Recover",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(200, 8, 185, 220),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// -----------------------------------------

  /// button  widget for building text sign up .

  /// -----------------------------------------

  Widget loignButton() {
    return RaisedButton(
      elevation: 0,

      /// -----------------------------------------

      /// background shape for button.

      /// -----------------------------------------

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),

      onPressed: () {
        getData(emailController.text, passwordController.text,
            serverAddressController.text, portController.text);
      },

      textColor: Colors.white,

      padding: EdgeInsets.all(0.0),

      child: Container(
        alignment: Alignment.center,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.blue, Colors.lightBlue],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('Login',
            style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10))),
      ),
    );
  }

  /// -----------------------------------------

  /// signUp Text Row to navigate to sign up interface with helper method.

  /// -----------------------------------------

  Widget signUpTextRow(String serverAdd, String port) {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SignUpPage(serverAdd, port)),
                  (Route<dynamic> route) => false);

              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(200, 8, 185, 220),
                  fontSize: _large ? 19 : (_medium ? 17 : 15)),
            ),
          )
        ],
      ),
    );
  }

  getData(String email, String pass, String serverAdd, String port) async {
    Map data = {'email': email, 'password': pass};
    var jsonData = null;
    final sharedPreferences = await SharedPreferences.getInstance();
    String serverIP = 'http://' + serverAdd + ':' + port + '/api';

    // final Key = 'token';
    // final value = sharedPreferences.get(Key) ?? 0;
    // print("sssssssssssssss" + value.toString());
    var response = await http.post(
      Uri.parse('$serverIP/auth/customer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        // 'x-auth-token': '$value',
      },
      body: jsonEncode(data),
    );
    print("-----------------------------");
    print(email + pass);
    print(json.decode(response.body).toString());
    if (response.statusCode == 200) {
      // print("ttttttttttt" + sharedPreferences.getString('token'));
      // Navigator.pushNamed(context, MyHomePage.routeName);

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
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  MyHomePage(user, serverAdd, port)),
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

      // print('data : ${jsonData["token"]}');

      setState(() {
        dbhelper.save(jsonData["token"]);
      });
      print("login successfuly 200 OK");

      print("Routing to your account");

      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text('Login Successful'),
      //   duration: Duration(
      //     milliseconds: 750,
      //   ),
      // ));
    } else
      print("login Error 101 ");
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Colors.orange, Colors.lightBlue],
          ),
          // color: Color.fromARGB(200, 8, 185, 220),
        ),
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
        cursorColor: Colors.orange[200],
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
