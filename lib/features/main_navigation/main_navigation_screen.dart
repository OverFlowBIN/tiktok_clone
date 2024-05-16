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
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectIndex,
          onDestinationSelected: _onTap,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const [
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.house),
              label: "Home",
            ),
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
              label: "Search",
            ),
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.star),
              label: "Setting",
            ),
          ],
        ));
  }
}
