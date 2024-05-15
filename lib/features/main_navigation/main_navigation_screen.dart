import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationNavogation extends StatefulWidget {
  const MainNavigationNavogation({super.key});

  @override
  State<MainNavigationNavogation> createState() =>
      _MainNavigationNavogationState();
}

class _MainNavigationNavogationState extends State<MainNavigationNavogation> {
  int _selectIndex = 0;

  final screens = [
    const Center(
      child: Text("Home"),
    ),
    const Center(
      child: Text("Search"),
    ),
    const Center(
      child: Text("Setting"),
    ),
  ];

  void _onTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onTap,
          currentIndex: _selectIndex,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black38,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house),
              label: 'Home',
              backgroundColor: Colors.amber,
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
              label: "Search",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.staylinked),
              label: "Setting",
              backgroundColor: Colors.green,
            ),
          ]),
    );
  }
}
