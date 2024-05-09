import 'package:devu_app/data/resource.dart';
import 'package:devu_app/page/add_category_page.dart';
import 'package:devu_app/page/add_expenses_page.dart';
import 'package:devu_app/page/add_label_page.dart';
import 'package:devu_app/page/asset_page.dart';
import 'package:devu_app/page/detail_asset_page.dart';
import 'package:devu_app/page/detail_category_page.dart';
import 'package:devu_app/page/main_page.dart';
import 'package:devu_app/page/setting_page.dart';
import 'package:devu_app/page/setup_asset_page.dart';
import 'package:flutter/material.dart';

class NavigationBarPage extends StatefulWidget {
  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    MainPage(),
    AssetPage('/setupAsset'),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/addCategory': (context) => AddCategoryPage(),
        '/addExpenses': (context) => AddExpensesPage(),
        '/setupAsset': (context) => SetupAssetPage(),
        '/detailCategory': (context) => DetailCategoryPage(),
        '/detailAsset': (context) => DetailAssetPage(),
      },
      home: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money), label: 'Asset'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Setting'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          onTap: onItemTapped,
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
