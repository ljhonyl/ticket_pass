import 'package:flutter/material.dart';
import 'package:fluentui_icons/fluentui_icons.dart';

class MenuNavegacion extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const MenuNavegacion({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(FluentSystemIcons.ic_fluent_ticket_regular),
          label: 'Tickets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Cuenta',
        ),
      ],
    );
  }
}
