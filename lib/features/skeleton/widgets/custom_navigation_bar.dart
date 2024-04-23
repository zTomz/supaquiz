import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final TabsRouter autoTabsRouter;

  const CustomNavigationBar({
    super.key,
    required this.autoTabsRouter,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.leaderboard_rounded),
          label: "Leaderboard",
        ),
        NavigationDestination(
          icon: Icon(Icons.person_rounded),
          label: "Profile",
        ),
      ],
      selectedIndex: autoTabsRouter.activeIndex,
      onDestinationSelected: (int index) {
        autoTabsRouter.setActiveIndex(index);
      },
    );
  }
}
