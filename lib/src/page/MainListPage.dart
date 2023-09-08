import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'MainPage.dart';
import '../bloc/business_logic.dart';

class MainListPage extends StatefulWidget {
  const MainListPage({Key? key}) : super(key: key);

  @override
  State<MainListPage> createState() => _MainListPageState();
}

class _MainListPageState extends State<MainListPage>{

  final PageController pageController = PageController();
  final restaurantItemBloc _itemBloc = MainPage.itemBloc;

  @override
  void initState(){
    super.initState();
    
    Timer.periodic(Duration(seconds: 7), (timer) {
      int? nextPage = pageController.page?.toInt();

      if(nextPage == null){
        return;
      }

      if(nextPage == 9){
        nextPage = 0;
      }else{
        nextPage++;
      }

      pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    },
    );
  }
  
  @override
  Widget build(BuildContext context) {

    return PageView(
      controller: pageController,
      children: [0,1,2,3,4,5,6,7,8,9]
      .map(
          (number) => WebView(
            initialUrl: _itemBloc.m_restaurantList[number].placeUrl,
            javascriptMode: JavascriptMode.unrestricted,
          ),
      ).toList(),
    );
  }
}
