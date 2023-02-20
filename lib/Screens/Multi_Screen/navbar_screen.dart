import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBarScreen extends StatelessWidget {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GNav(
      backgroundColor: Colors.blueAccent,
      hoverColor: Colors.blueGrey,
      color: Colors.white,
      activeColor: Colors.white,
      gap: 8,
      onTabChange: (index){
        print(index);
      },
      padding: EdgeInsets.all(16),
      tabs: [
        GButton(
          icon: Icons.home,
          text: "Home",
        ),
        GButton(
          icon: Icons.favorite_border,
          text: "Likes",
        ),
        GButton(
          icon: Icons.search,
          text: "Search",
        ),
        GButton(
          icon: Icons.settings,
          text: "Settings",
        ),
      ],
    );
  }
}
