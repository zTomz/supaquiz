import 'package:auto_route/auto_route.dart';

import '../../../features/auth/presentation/pages/auth_page.dart';
import '../../../features/leaderboard/presentation/pages/leaderboard_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
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
              page: SkeletonRoute.page,
              initial: false,
              keepHistory: false,
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
          ],
        ),
      ];
}

final appRouter = AppRouter();
