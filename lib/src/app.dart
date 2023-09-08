import 'package:flutter/material.dart';
import 'page/LogoPage.dart';
import 'page/MainPage.dart';

class FlicstaurantApp extends StatelessWidget {
  final int? pageId;

  const FlicstaurantApp({super.key, this.pageId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: pageId == null
          ? const LogoPage()
          : MainPage(key: Key("mainPage_$pageId")));
  }
}