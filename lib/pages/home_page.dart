import 'package:flutter/material.dart';
import 'package:sandbox_app1/components/bottom_nav_bar.dart';
import 'package:sandbox_app1/models/user.dart';
import 'package:sandbox_app1/pages/account_page.dart';
import 'package:sandbox_app1/pages/goods_list_page.dart';

class HomePage extends StatefulWidget {
  final User _user;

  const new({super.key, required this._user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _selectedIndex;

  List<Widget>? _pages;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = 0;
    _pages = [GoodsList(), AccountPage(user: widget._user)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: SafeArea(
        child: BottomNavBar(onTabChange: navigateBottomBar),
      ),
      body: _pages![_selectedIndex!],
    );
  }
}
