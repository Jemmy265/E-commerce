import 'package:ecommerce/ui/home/bottom_nav_icon.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/home_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int SelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
                child: Container(
              child: TextField(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(width: 1,color: Theme.of(context).primaryColor)
              ),
            )),
            ImageIcon(
              AssetImage("assets/images/cart.png"),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: BottomNavigationBar(
          currentIndex: SelectedIndex,
          onTap: (index) {
            setState(() {
              SelectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: BottomNavIcon(
                  iconName: "home_icon",
                  isSelected: true,
                ),
                label: ""),
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: BottomNavIcon(
                  iconName: "category_icon",
                  isSelected: false,
                ),
                label: ""),
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: BottomNavIcon(
                  iconName: "heart_icon",
                  isSelected: false,
                ),
                label: ""),
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: BottomNavIcon(
                  iconName: "user_icon",
                  isSelected: false,
                ),
                label: ""),
          ],
        ),
      ),
      body: HomeTab(),
    );
  }
}
