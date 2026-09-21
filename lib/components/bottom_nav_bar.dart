import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;
  const new({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return GNav(
      color: Colors.grey[400],
      activeColor: Colors.grey[800],
      tabBackgroundColor: Colors.white,
      mainAxisAlignment: MainAxisAlignment.center,
      tabBorderRadius: 20,
      onTabChange: onTabChange,
      tabs: [
        GButton(icon: Icons.list, text: "Список товаров"),
        GButton(icon: Icons.person, text: "Аккаунт"),
      ],
    );
  }
}
