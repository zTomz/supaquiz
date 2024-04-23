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

        return Scaffold(
          body: child,
          floatingActionButton: autoTabsRouter.activeIndex == 0
              ? const CustomFloatingActionButton()
              : null,
          bottomNavigationBar: CustomNavigationBar(
            autoTabsRouter: autoTabsRouter,
          ),
        );
      },
    );
  }
}
