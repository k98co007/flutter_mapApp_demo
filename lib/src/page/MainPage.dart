import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'MainMapPage.dart';
import 'MainListPage.dart';
import 'MainSettingPage.dart';

import '../bloc/business_logic.dart';



class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static final restaurantItemBloc itemBloc = restaurantItemBloc();

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  var selectedIndex = 0;

  final restaurantItemBloc _itemBloc = MainPage.itemBloc;


  @override
  void initState(){
    super.initState();
    _itemBloc.listUpItems();
  }

  @override
  void dispose() {
    super.dispose();
    _itemBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page = MainMapPage();
    switch (selectedIndex) {
      case 0:
        page = MainMapPage();
        break;
      case 1:
        page = MainListPage();
        break;
      case 2:
        page = MainSettingPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // The container for the current page, with its background color
    // and subtle switching animation.
    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            top: true,
            bottom: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: mainArea),
                BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                    icon: Icon(Icons.map),
                    label: 'Map',
                    ),
                    BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'List',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Setting',
                    ),
                  ],
                  currentIndex: selectedIndex,
                  onTap: (value) {
                    setState(() {
                    selectedIndex = value;
                    });
                  },
                ),
              ],
            )
          );
        },
      ),
    );
  }
}
