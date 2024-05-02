// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const Home(),
      );
    },
    LeaderboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LeaderboardPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    PublicProfileRoute.name: (routeData) {
      final args = routeData.argsAs<PublicProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PublicProfilePage(
          key: args.key,
          user: args.user,
          username: args.username,
        ),
      );
    },
    QuizEndRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const QuizEndPage(),
      );
    },
    QuizRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const QuizPage(),
      );
    },
    ReleaseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ReleasePage(),
      );
    },
    SkeletonRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const Skeleton(),
      );
    },
  };
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [Home]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LeaderboardPage]
class LeaderboardRoute extends PageRouteInfo<void> {
  const LeaderboardRoute({List<PageRouteInfo>? children})
      : super(
          LeaderboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'LeaderboardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PublicProfilePage]
class PublicProfileRoute extends PageRouteInfo<PublicProfileRouteArgs> {
  PublicProfileRoute({
    Key? key,
    required UserModel user,
    required String username,
    List<PageRouteInfo>? children,
  }) : super(
          PublicProfileRoute.name,
          args: PublicProfileRouteArgs(
            key: key,
            user: user,
            username: username,
          ),
          rawPathParams: {'username': username},
          initialChildren: children,
        );

  static const String name = 'PublicProfileRoute';

  static const PageInfo<PublicProfileRouteArgs> page =
      PageInfo<PublicProfileRouteArgs>(name);
}

class PublicProfileRouteArgs {
  const PublicProfileRouteArgs({
    this.key,
    required this.user,
    required this.username,
  });

  final Key? key;

  final UserModel user;

  final String username;

  @override
  String toString() {
    return 'PublicProfileRouteArgs{key: $key, user: $user, username: $username}';
  }
}

/// generated route for
/// [QuizEndPage]
class QuizEndRoute extends PageRouteInfo<void> {
  const QuizEndRoute({List<PageRouteInfo>? children})
      : super(
          QuizEndRoute.name,
          initialChildren: children,
        );

  static const String name = 'QuizEndRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [QuizPage]
class QuizRoute extends PageRouteInfo<void> {
  const QuizRoute({List<PageRouteInfo>? children})
      : super(
          QuizRoute.name,
          initialChildren: children,
        );

  static const String name = 'QuizRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReleasePage]
class ReleaseRoute extends PageRouteInfo<void> {
  const ReleaseRoute({List<PageRouteInfo>? children})
      : super(
          ReleaseRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReleaseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [Skeleton]
class SkeletonRoute extends PageRouteInfo<void> {
  const SkeletonRoute({List<PageRouteInfo>? children})
      : super(
          SkeletonRoute.name,
          initialChildren: children,
        );

  static const String name = 'SkeletonRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
