import 'package:cmsapp/screens/sign_in.dart';
import 'package:cmsapp/screens/sign_up.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SignInScreen.routeName,
      // initialRoute: MyHomePage.routeName,
      routes: {
        SignInScreen.routeName: (context) => SignInScreen(),
        // SignUpPage.routeName: (context) => SignUpPage(),
        // DetailsComplaint.routeName: (context) => DetailsComplaint(),
        // MyHomePage.routeName: (context) => MyHomePage(User:user),
      },
    );
  }
}
