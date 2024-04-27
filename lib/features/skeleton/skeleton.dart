import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/config/router/app_router.dart';
import 'widgets/custom_floating_action_button.dart';
import 'widgets/custom_navigation_bar.dart';

@RoutePage(
  name: "SkeletonRoute",
)
class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        LeaderboardRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final autoTabsRouter = AutoTabsRouter.of(context);
        final useNavigationBar = MediaQuery.sizeOf(context).width < 500;

        return Scaffold(
          body: useNavigationBar
              ? child
              : Row(
                  children: [
                    NavigationRail(
                      labelType: NavigationRailLabelType.all,
                      groupAlignment: 0,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.leaderboard_rounded),
                          label: Text("Leaderboard"),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.person_rounded),
                          label: Text("Profile"),
                        ),
                      ],
                      selectedIndex: autoTabsRouter.activeIndex,
                      onDestinationSelected: (value) {
                        autoTabsRouter.setActiveIndex(value);
                      },
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(child: child),
                  ],
                ),
          floatingActionButton: autoTabsRouter.activeIndex == 0
              ? const CustomFloatingActionButton()
              : null,
          bottomNavigationBar: useNavigationBar
              ? CustomNavigationBar(
                  autoTabsRouter: autoTabsRouter,
                )
              : null,
        );
      },
    );
  }
}
