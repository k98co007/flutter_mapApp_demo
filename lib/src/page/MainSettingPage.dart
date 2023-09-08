import 'package:flutter/material.dart';
import 'MainPage.dart';

class MainSettingPage extends StatelessWidget {
  const MainSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child:Text(
                "this is page for setting",
                style:
                const TextStyle(fontSize: 16, color: Colors.black),
              ),
            )
        )
    );
  }
}