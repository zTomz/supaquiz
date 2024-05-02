import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../features/about/presentation/pages/release_page.dart';
import '../../../features/auth/presentation/pages/auth_page.dart';
import '../../../features/leaderboard/data/models/user_model.dart';
import '../../../features/leaderboard/presentation/pages/leaderboard_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../../features/leaderboard/presentation/pages/public_profile_page.dart';
import '../../../features/quiz/presentation/pages/quiz_end_page.dart';
import '../../../features/quiz/presentation/pages/quiz_page.dart';
import '../../../features/skeleton/skeleton.dart';
import '../../../main.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
          initial: true,
          children: [
            AutoRoute(
              path: 'auth',
              page: AuthRoute.page,
              keepHistory: false,
            ),
            AutoRoute(
              path: '',
              page: SkeletonRoute.page,
              children: [
                AutoRoute(
                  path: 'leaderboard',
                  page: LeaderboardRoute.page,
                  type: const RouteType.custom(),
                ),
                AutoRoute(
                  path: 'profile',
                  page: ProfileRoute.page,
                  type: const RouteType.custom(),
                ),
              ],
            ),
            AutoRoute(
              path: 'quiz',
              page: QuizRoute.page,
            ),
            AutoRoute(
              path: 'finished',
              page: QuizEndRoute.page,
            ),
            AutoRoute(
              path: 'users/:username',
              fullscreenDialog: true,
              page: PublicProfileRoute.page,
              type: const RouteType.custom(),
            ),
            AutoRoute(
              path: 'release',
              fullscreenDialog: true,
              page: ReleaseRoute.page,
            ),
          ],
        ),
      ];
}

final appRouter = AppRouter();
