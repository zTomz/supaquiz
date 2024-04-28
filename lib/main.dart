import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/router/app_router.dart';
import 'core/config/supabase/setup.dart';
import 'core/config/themes/app_theme.dart';
import 'core/utils/resources/supabase.dart';
import 'features/leaderboard/presentation/provider/user_provider.dart';
import 'features/quiz/presentation/provider/quiz_provider.dart';

Future<void> main() async {
  usePathUrlStrategy();

  await setupSupabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuizProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp.router(
        title: 'SupaQuiz',
        theme: AppTheme.lightTheme,
        // darkTheme: AppTheme.darkTheme,
        routerConfig: appRouter.config(),
      ),
    );
  }
}

@RoutePage(
  name: "HomeRoute",
)
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    // If user is not signed in, send to auth page
    if (supabase.auth.currentUser == null) {
      appRouter.push(const AuthRoute());
    } else {
      appRouter.replace(const SkeletonRoute());
    }

    supabase.auth.onAuthStateChange.listen((data) {
      // If user signed in, send to skeleton page
      if (data.event == AuthChangeEvent.signedIn) {
        appRouter.push(const SkeletonRoute());
      }

      // If user signed out, send to auth page
      if (data.event == AuthChangeEvent.signedOut ||
          data.event == AuthChangeEvent.userDeleted) {
        appRouter.push(const AuthRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
