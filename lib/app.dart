import 'package:store_app/Screens/loginScreen/login_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  //loging Screen or SignUp Screen

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoginScreen());
  }
}
