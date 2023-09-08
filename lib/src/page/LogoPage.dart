import 'package:flutter/material.dart';
import 'dart:async';
import 'MainPage.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), (){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MainPage()));
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
          child: Center(
            child: Image.asset('assets/images/logo.jpg'),
          )
      )
    );
  }
}