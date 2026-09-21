import 'package:flutter/material.dart';
import 'package:sandbox_app1/components/bottom_nav_bar.dart';
import 'package:sandbox_app1/pages/account_page.dart';
import 'package:sandbox_app1/pages/goods_list_page.dart';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [GoodsList(), AccountPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: SafeArea(
        child: BottomNavBar(onTabChange: navigateBottomBar),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
